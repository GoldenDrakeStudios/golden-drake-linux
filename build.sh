#!/usr/bin/env bash

REPO_DIR="$(pwd)"
ARCHISO_DIR=/usr/share/archiso/configs/releng
SRC_DIR="${REPO_DIR}"/src

if [ "${iscontainer}" = "yes" ]; then
  REPO_DIR=/gdl
  SRC_DIR=/gdl

  # Update packages with reflector
  reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
fi

PROFILE_DIR="${REPO_DIR}"/profile

# Check root permission
check_root() {
  [ "$(id -u)" -ne 0 ] && echo "$0 needs to be run with root permissions" && exit
}

# Check if dependencies are installed
check_deps() {
  if ! pacman -Qi archiso >/dev/null 2>&1 || ! pacman -Qi mkinitcpio-archiso >/dev/null 2>&1; then
    pacman -Syq --noconfirm archiso mkinitcpio-archiso
  fi
}

prepare_build_dir() {
  # Create temporary directory if it doesn't exist
  [ ! -d "${PROFILE_DIR}" ] && mkdir "${PROFILE_DIR}"

  # Copy Archiso files to tmp dir
  cp -r "${ARCHISO_DIR}"/* "${PROFILE_DIR}"/

  # Copy GDL files to tmp dir
  cp -rf "${SRC_DIR}"/root/. "${PROFILE_DIR}"/airootfs/root/
  cp -rf "${SRC_DIR}"/usr/. "${PROFILE_DIR}"/airootfs/usr/
  cp -rf "${SRC_DIR}"/etc/. "${PROFILE_DIR}"/airootfs/etc/

  # Copy splash.png to bootloader directory
  cp -f "${REPO_DIR}"/assets/splash.png "${PROFILE_DIR}"/airootfs/usr/share/gdl/boot/splash.png

  # Copy GDL logo to extras
  cp -f "${REPO_DIR}"/assets/logo.png "${PROFILE_DIR}"/airootfs/usr/share/gdl/extra/gdl-icon.png

  echo "chmod +x /usr/bin/gdl* && gdl" >>"${PROFILE_DIR}"/airootfs/root/.zlogin

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
    'zsh-syntax-highlighting'
  )

  for package in "${packages[@]}"; do
    echo "${package}" >>"${PROFILE_DIR}"/packages.x86_64
  done

  # Customize bootloader
  cp -f "${REPO_DIR}"/assets/splash.png "${PROFILE_DIR}"/syslinux/splash.png
  sed -i 's/Arch Linux install medium/GDL Arch Installer/' "${PROFILE_DIR}"/efiboot/loader/entries/archiso-x86_64-linux.conf
  sed -i 's/Arch Linux install medium/GDL Arch Installer/' "${PROFILE_DIR}"/syslinux/archiso_sys-linux.cfg
  sed -i 's/Arch Linux/Arch/' "${PROFILE_DIR}"/syslinux/archiso_sys-linux.cfg
  sed -i 's/It allows you/Allows you/' "${PROFILE_DIR}"/syslinux/archiso_sys-linux.cfg
  sed -i 's/Arch Linux install medium/GDL Arch Installer/' "${PROFILE_DIR}"/syslinux/archiso_pxe-linux.cfg
  sed -i 's/Arch Linux/Arch/' "${PROFILE_DIR}"/syslinux/archiso_pxe-linux.cfg
  sed -i 's/It allows you/Allows you/' "${PROFILE_DIR}"/syslinux/archiso_pxe-linux.cfg
  sed -i 's/Arch Linux/Golden Drake Linux (GDL) - Arch Installer/' "${PROFILE_DIR}"/syslinux/archiso_head.cfg
  sed -i 's/border       30;44   #40ffffff #a0000000/border       31;40   #80ff2400 #d0000000/' "${PROFILE_DIR}"/syslinux/archiso_head.cfg
  sed -i 's/title        1;36;44 #9033ccff #a0000000/title        1;33;40 #f0ffd700 #d0000000/' "${PROFILE_DIR}"/syslinux/archiso_head.cfg
  sed -i 's/sel          7;37;40 #e0ffffff #20ffffff/sel          7;33;41 #f0ffd700 #40ff2400/' "${PROFILE_DIR}"/syslinux/archiso_head.cfg
  sed -i 's/unsel        37;44   #50ffffff #a0000000/unsel        33;40   #80d4af37 #d0000000/' "${PROFILE_DIR}"/syslinux/archiso_head.cfg
  sed -i 's/help         37;40   #c0ffffff #a0000000/help         33;40   #f0d4af37 #00000000/' "${PROFILE_DIR}"/syslinux/archiso_head.cfg
  sed -i 's/timeout_msg  37;40   #80ffffff #00000000/timeout_msg  33;40   #d0da9100 #00000000/' "${PROFILE_DIR}"/syslinux/archiso_head.cfg
  sed -i 's/timeout      1;37;40 #c0ffffff #00000000/timeout      1;31;40 #f0ff2400 #00000000/' "${PROFILE_DIR}"/syslinux/archiso_head.cfg
  sed -i 's/msg07        37;40   #90ffffff #a0000000/msg07        33;40   #f0d4af37 #d0000000/' "${PROFILE_DIR}"/syslinux/archiso_head.cfg
  sed -i 's/tabmsg       31;40   #30ffffff #00000000/tabmsg       33;40   #d0da9100 #00000000/' "${PROFILE_DIR}"/syslinux/archiso_head.cfg
}

ssh_config() {
  # Check optional configuration file for SSH connection
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
    podman build --rm -t gdl --no-cache -f ./Containerfile &&
      podman run --rm -v "${REPO_DIR}"/out:/gdl/out -t -i --privileged localhost/gdl &&
      podman image rm localhost/gdl
    exit
    ;;
  *)
    echo "Usage: $0 [-c | --container]"
    exit 1
    ;;
  esac
fi
