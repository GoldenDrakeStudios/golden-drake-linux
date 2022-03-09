#!/bin/bash
#
# Build script for the Golden Drake Linux (GDL) installer. If building within a
# non-Arch Linux environment, a '-c' flag should be included in order to use an
# Arch Linux container for the build process (requires 'podman').
#
# Copyright (C) 2020-2022 Golden Drake Studios: goldendrakestudios.com
# Forked originally from the Anarchy installer: anarchyinstaller.gitlab.io
#
# shellcheck disable=SC2015,SC2154,SC2155

if [[ "${iscontainer}" == 'yes' ]]; then
  readonly REPO_DIR='/gdl'
else
  readonly REPO_DIR="$(pwd)"
fi
readonly ADDITIONAL_PACKAGES=(
  'arch-wiki-lite'
  'base-devel'
  'cowsay'
  'dialog'
  'git'
  'networkmanager'
  'tree'
  'wget'
)

################################################################################
# Present a message as if spoken by an ASCII dragon via 'cowsay' (or simply echo
# the message if cowsay isn't installed).
#
# Globals: None
# Arguments: A string of text to be presented. A second argument of '--error'
#   will compel the ASCII dragon to attack an ASCII cow.
# Outputs: The desired message.
################################################################################
function dragonsay() {
  if ! pacman -Q cowsay &>/dev/null; then
    echo "$1"
  elif [[ "$2" == '--error' ]]; then
    cowsay -f dragon-and-cow "$1"
  else
    cowsay -f dragon "$1"
  fi
}

################################################################################
# Given a set of dependencies, attempt to install any not yet installed.
#
# Globals: None
# Arguments: One or more package names (as separate strings).
# Outputs: Number of failed installation attempts.
################################################################################
function install_dependencies() {
  local dep
  local -i failed_installs=0

  for dep in "$@"; do
    if ! pacman -Q "${dep}" &>/dev/null &&
       ! pacman -Sy --noconfirm "${dep}"; then
      dragonsay "ERROR: Failed to install missing dependency '${dep}'." --error
      (( ++failed_installs ))
    fi
  done

  return "${failed_installs}"
}

################################################################################
# Prepare a custom "profile" directory for later use by Archiso.
#
# Globals: REPO_DIR, ADDITIONAL_PACKAGES
# Arguments: None
# Outputs: Number of errors encountered.
################################################################################
function prepare_build_dir() {
  local package file

  # Copy archiso files to profile dir
  mkdir "${REPO_DIR}"/profile
  cp -rT /usr/share/archiso/configs/releng "${REPO_DIR}"/profile || return 1

  # Copy GDL files to profile dir
  cp -f "${REPO_DIR}"/profiledef.sh "${REPO_DIR}"/profile
  cp -f "${REPO_DIR}"/.zlogin "${REPO_DIR}"/profile/airootfs/root
  cp "${REPO_DIR}"/.dialogrc "${REPO_DIR}"/profile/airootfs/root
  cp "${REPO_DIR}"/extra/skel/.vimrc "${REPO_DIR}"/profile/airootfs/root
  cp -rT "${REPO_DIR}"/etc "${REPO_DIR}"/profile/airootfs/etc
  mkdir "${REPO_DIR}"/profile/airootfs/usr/bin
  cp "${REPO_DIR}"/gdl "${REPO_DIR}"/profile/airootfs/usr/bin
  mkdir -p "${REPO_DIR}"/profile/airootfs/usr/share/gdl
  cp -r "${REPO_DIR}"/extra "${REPO_DIR}"/profile/airootfs/usr/share/gdl
  cp -r "${REPO_DIR}"/lang "${REPO_DIR}"/profile/airootfs/usr/share/gdl

  # Configure pacman for a more aesthetic build process
  sed -i 's/#Color/Color\nILoveCandy/' "${REPO_DIR}"/profile/pacman.conf

  # Remove "message of the day"
  rm "${REPO_DIR}"/profile/airootfs/etc/motd

  # Set installer's hostname and console font
  echo 'gdl' >"${REPO_DIR}"/profile/airootfs/etc/hostname
  echo -e "127.0.0.1 localhost\n::1 localhost\n127.0.1.1 gdl.localdomain gdl" \
    >>"${REPO_DIR}"/profile/airootfs/etc/hosts
  echo 'FONT=ter-v16n' >>"${REPO_DIR}"/profile/airootfs/etc/vconsole.conf

  # Add GDL-specific packages to the package list
  for package in "${ADDITIONAL_PACKAGES[@]}"; do
    echo "${package}" >>"${REPO_DIR}"/profile/packages.x86_64
  done

  # Customize bootloader
  for file in "${REPO_DIR}"/profile/efiboot/loader/entries/*; do
    sed -i 's/Arch Linux install medium/GDL Arch Installer/' "${file}"
  done
  file="${REPO_DIR}"/profile/syslinux/archiso_sys-linux.cfg
  sed -i 's/Arch Linux install medium/GDL Arch Installer/' "${file}"
  sed -i 's/Arch Linux/Arch/' "${file}"
  sed -i 's/It allows you/Allows you/' "${file}"
  file="${REPO_DIR}"/profile/syslinux/archiso_pxe-linux.cfg
  sed -i 's/Arch Linux install medium/GDL Arch Installer/' "${file}"
  sed -i 's/Arch Linux/Arch/' "${file}"
  sed -i 's/It allows you/Allows you/' "${file}"
  file="${REPO_DIR}"/profile/syslinux/archiso_head.cfg
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
  cp -f "${REPO_DIR}"/splash.png "${REPO_DIR}"/profile/syslinux/
}

################################################################################
# Create a GDL ISO image and associated checksum file in an 'out' directory.
#
# Globals: REPO_DIR
# Arguments: None
# Outputs: Number of errors encountered.
################################################################################
function generate_iso() {
  local filename

  if ! cd "${REPO_DIR}" || ! mkarchiso -v "${REPO_DIR}"/profile; then
    dragonsay "ERROR: Unable to create ISO file." --error
    return 1
  fi
  filename="$(basename "$(find "${REPO_DIR}"/out -name 'gdl-*.iso')")"
  if ! cd "${REPO_DIR}"/out || [[ ! -f "${filename}" ]] ||
      ! sha512sum --tag "${filename}" >"${filename}".sha512sum; then
    dragonsay "ERROR: Unable to get checksum for file '${filename}'." --error
    return 1
  fi
}

################################################################################
# Facilitate the creation of a GDL ISO image and checksum file.
#
# Globals: REPO_DIR
# Arguments: Optional '-c' if building via container.
# Outputs: New files are placed in an 'out' directory.
################################################################################
function main() {
  if (( $(id -u) != 0 )) || [[ -n "$1" && "$1" != '-c' ]]; then # show usage
    dragonsay "Usage: sudo ./build.sh [-c]"
  elif [[ "$1" == '-c' ]]; then # set up an Arch Linux container via podman
    [[ ! -d "${REPO_DIR}"/out ]] && mkdir "${REPO_DIR}"/out
    podman build --rm -t gdl --no-cache -f ./Containerfile && podman run --rm \
      --rmi -tiv "${REPO_DIR}"/out:/gdl/out --privileged localhost/gdl ||
      dragonsay "ERROR: Building via podman failed." --error
  else # build
    install_dependencies 'archiso' 'cowsay' && prepare_build_dir &&
      generate_iso && dragonsay "Your Golden Drake Linux ISO is ready!"
    rm -r "${REPO_DIR}"/work "${REPO_DIR}"/profile # remove temp folders
  fi
}

main "$@"
