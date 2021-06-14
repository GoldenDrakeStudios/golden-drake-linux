#!/bin/bash

REPO_DIR="$(pwd)"
SRC_DIR="${REPO_DIR}"/src
if [ "${iscontainer}" = "yes" ]; then
  REPO_DIR=/gdl
  SRC_DIR=/gdl
  reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
fi
ARCHISO_DIR=/usr/share/archiso/configs/releng
PROFILE_DIR="${REPO_DIR}"/profile
SUCCESS_STR="Huzzah! Rejoice, human: your Golden Drake Linux ISO is ready!"
USAGE_STR="Usage: ./build.sh [-c | --container]"
ROOT_STR="This script must be run with root permissions (e.g., sudo)."

dragonsay() {
  cowsay -f dragon "$1"
}

check_root_permissions() {
  if [ "$(id -u)" -ne 0 ]; then
    if pacman -Qi cowsay &>/dev/null; then
      dragonsay "Sorry, human! ${ROOT_STR}"
    else
      echo "${ROOT_STR}"
    fi
    exit
  fi
}

install_missing_dependencies() {
  for dep in "$@"; do
    if ! pacman -Qi "${dep}" &>/dev/null; then
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
    "${PROFILE_DIR}"/airootfs/usr/share/gdl/extra/gdl.png

  # Replace profiledef file
  rm "${PROFILE_DIR}"/profiledef.sh
  cp "${REPO_DIR}"/profiledef.sh "${PROFILE_DIR}"/

  # Remove motd since it's not useful in GDL
  rm "${PROFILE_DIR}"/airootfs/etc/motd

  # Set installer's hostname and console font
  echo "gdl" >"${PROFILE_DIR}"/airootfs/etc/hostname
  echo "FONT=ter-v16n" >>"${PROFILE_DIR}"/airootfs/etc/vconsole.conf

  # Add GDL packages
  packages=('arch-wiki-lite' 'base-devel' 'cowsay' 'dialog' 'git'
    'networkmanager' 'wget')
  for package in "${packages[@]}"; do
    echo "${package}" >>"${PROFILE_DIR}"/packages.x86_64
  done

  # Customize bootloader, etc.
  local file
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
  file="${PROFILE_DIR}"/airootfs/root/.zlogin
  echo -e "\nalias installer='gdl'\nalias ls='ls -F --color=auto'\nalias l='ls'
alias la='ls -A'\nalias ll='ls -l'\nalias lla='ls -lA'\nalias grep='grep \
--color=auto'\nalias histgrep='history | grep'\nalias ps='ps auxf'\nalias \
psgrep='ps -e | grep -i'\nalias vi='vim'\nalias cp='cp -i'\nalias mv='mv -i'
alias mkdir='mkdir -pv'\nalias free='free -t'\nalias df='df -T'\nalias du='du \
-ach | sort -h'\n\ngdl" >>"${file}"
}

generate_iso() {
  cd "${REPO_DIR}" || exit
  mkarchiso -v "${PROFILE_DIR}" || exit
}

generate_checksum() {
  cd "${REPO_DIR}"/out || exit
  filename="$(basename "$(find . -name 'gdl-*.iso')")"
  if [ ! -f "${filename}" ]; then
    echo "Error: ISO file not found; unable to generate checksum."
    exit
  fi
  sha512sum --tag "${filename}" >"${filename}".sha512sum || exit
}

main() {
  check_root_permissions
  install_missing_dependencies 'archiso' 'mkinitcpio-archiso' 'cowsay'
  prepare_build_dir
  generate_iso
  generate_checksum
  # Comment the following line if you want to investigate these temp folders
  rm -r "${REPO_DIR}"/work "${REPO_DIR}"/profile
  dragonsay "${SUCCESS_STR}"
}

if [ $# -eq 0 ]; then
  main
else
  case "$1" in
  -c | --container)
    check_root_permissions
    install_missing_dependencies 'podman'
    [ ! -d "${REPO_DIR}"/out ] && mkdir "${REPO_DIR}"/out
    podman build --rm -t gdl --no-cache -f ./Containerfile && podman run --rm \
      -v "${REPO_DIR}"/out:/gdl/out -t -i --privileged localhost/gdl && podman \
      image rm localhost/gdl
    exit
    ;;
  *)
    if pacman -Qi cowsay &>/dev/null; then
      dragonsay "${USAGE_STR}"
    else
      echo "${USAGE_STR}"
    fi
    exit 1
    ;;
  esac
fi
