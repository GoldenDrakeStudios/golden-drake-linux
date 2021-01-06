#!/usr/bin/env bash

REPO_DIR="$(pwd)"
ARCHISO_DIR=/usr/share/archiso/configs/releng
SRC_DIR="${REPO_DIR}"/src

if [ "${iscontainer}" = "yes" ]; then
  REPO_DIR=/gdl
  SRC_DIR=/gdl
  reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
fi

PROFILE_DIR="${REPO_DIR}"/profile

# Check for root permissions
check_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "$0 needs to be run with root permissions"
    exit
  fi
}

# Install missing dependencies
check_deps() {
  deps=("archiso" "mkinitcpio-archiso")
  for dep in "${deps[@]}"; do
    if ! pacman -Qi "${dep}" >/dev/null 2>&1; then
      pacman -Sy --noconfirm "${dep}"
    fi
  done
}

prepare_build_dir() {
  # Create profile directory if it doesn't exist
  [ ! -d "${PROFILE_DIR}" ] && mkdir "${PROFILE_DIR}"

  # Copy archiso files to profile dir
  cp -r "${ARCHISO_DIR}"/* "${PROFILE_DIR}"/

  # Copy GDL src files to profile dir
  cp -rf "${SRC_DIR}"/root/. "${PROFILE_DIR}"/airootfs/root/
  cp -rf "${SRC_DIR}"/usr/. "${PROFILE_DIR}"/airootfs/usr/
  cp -rf "${SRC_DIR}"/etc/. "${PROFILE_DIR}"/airootfs/etc/

  # Copy splash and logo images
  cp -f "${REPO_DIR}"/assets/splash.png \
    "${PROFILE_DIR}"/airootfs/usr/share/gdl/boot/splash.png
  cp -f "${REPO_DIR}"/assets/logo.png \
    "${PROFILE_DIR}"/airootfs/usr/share/gdl/extra/gdl-icon.png

  # Replace profiledef file
  rm "${PROFILE_DIR}"/profiledef.sh
  cp "${REPO_DIR}"/profiledef.sh "${PROFILE_DIR}"/

  # Remove motd since it's not useful in GDL
  rm "${PROFILE_DIR}"/airootfs/etc/motd

  # Set installer's hostname and console font
  echo "gdl" >"${PROFILE_DIR}"/airootfs/etc/hostname
  echo "FONT=ter-v16n" >>"${PROFILE_DIR}"/airootfs/etc/vconsole.conf

  # Add gdl packages
  packages=(
    'dialog'
    'git'
    'networkmanager'
    'wget'
  )
  for package in "${packages[@]}"; do
    echo "${package}" >>"${PROFILE_DIR}"/packages.x86_64
  done

  # Customize bootloader
  cp -f "${REPO_DIR}"/assets/splash.png "${PROFILE_DIR}"/syslinux/splash.png
  file="${PROFILE_DIR}"/efiboot/loader/entries/archiso-x86_64-linux.conf
  sed -i 's/Arch Linux install medium/GDL Arch Installer/' "${file}"
  file="${PROFILE_DIR}"/syslinux/archiso_sys-linux.cfg
  sed -i 's/Arch Linux install medium/GDL Arch Installer/' "${file}"
  sed -i 's/Arch Linux/Arch/' "${file}"
  sed -i 's/It allows you/Allows you/' "${file}"
  file="${PROFILE_DIR}"/syslinux/archiso_pxe-linux.cfg
  sed -i 's/Arch Linux install medium/GDL Arch Installer/' "${file}"
  sed -i 's/Arch Linux/Arch/' "${file}"
  sed -i 's/It allows you/Allows you/' "${file}"
  file="${PROFILE_DIR}"/syslinux/archiso_head.cfg
  sed -i 's/Arch Linux/Golden Drake Linux (GDL) - Arch Installer/' "${file}"
  sed -i 's/30;44   #40ffffff #a0000000/31;40   #80ff2400 #d0000000/' "${file}"
  sed -i 's/1;36;44 #9033ccff #a0000000/1;33;40 #f0ffd700 #d0000000/' "${file}"
  sed -i 's/7;37;40 #e0ffffff #20ffffff/7;33;41 #f0ffd700 #40ff2400/' "${file}"
  sed -i 's/37;44   #50ffffff #a0000000/33;40   #80d4af37 #d0000000/' "${file}"
  sed -i 's/37;40   #c0ffffff #a0000000/33;40   #f0d4af37 #00000000/' "${file}"
  sed -i 's/37;40   #80ffffff #00000000/33;40   #d0da9100 #00000000/' "${file}"
  sed -i 's/1;37;40 #c0ffffff #00000000/1;31;40 #f0ff2400 #00000000/' "${file}"
  sed -i 's/37;40   #90ffffff #a0000000/33;40   #f0d4af37 #d0000000/' "${file}"
  sed -i 's/31;40   #30ffffff #00000000/33;40   #d0da9100 #00000000/' "${file}"

  # Ensure GDL launches automatically when selected from bootloader
  echo "chmod +x /usr/bin/gdl && gdl" >>"${PROFILE_DIR}"/airootfs/root/.zlogin
}

ssh_config() {
  # Check for optional SSH configuration file
  if [ -f autoconnect.sh ]; then
    . autoconnect.sh
    # Copy PUBLIC_KEY to authorized_keys
    if [ ! -d airootfs/etc/skel/.ssh ]; then
      mkdir -p airootfs/etc/skel/.ssh
    fi
    cp "${PUBLIC_KEY}" airootfs/etc/skel/.ssh/authorized_keys
    chmod 700 airootfs/etc/skel/.ssh
    chmod 600 airootfs/etc/skel/.ssh/authorized_keys
  fi
}

geniso() {
  cd "${REPO_DIR}" || exit
  mkarchiso -v "${PROFILE_DIR}" || exit
}

checksum_gen() {
  cd "${REPO_DIR}"/out || exit
  filename="$(basename "$(find . -name 'gdl-*.iso')")"
  if [ ! -f "${filename}" ]; then
    echo "Missing file ${filename}"
    exit
  fi
  sha512sum --tag "${filename}" >"${filename}".sha512sum || exit
}

main() {
  check_root
  check_deps
  prepare_build_dir
  ssh_config
  geniso
  checksum_gen
}

if [ $# -eq 0 ]; then
  main
else
  case "$1" in
  -c | --container)
    check_root
    [ ! -d "${REPO_DIR}"/out ] && mkdir "${REPO_DIR}"/out
    podman build --rm -t gdl --no-cache -f ./Containerfile && podman run --rm \
      -v "${REPO_DIR}"/out:/gdl/out -t -i --privileged localhost/gdl && podman \
      image rm localhost/gdl
    exit
    ;;
  *)
    echo "Usage: $0 [-c | --container]"
    exit 1
    ;;
  esac
fi
