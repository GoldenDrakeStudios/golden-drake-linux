#!/bin/bash
#
# Build script for the Golden Drake Linux (GDL) installer. If not building in an
# Arch Linux environment, or if the build process fails, include a '-c' flag to
# build within an Arch Linux container via 'podman'.
#
# Copyright (C) 2020-2025 Golden Drake Studios: goldendrakestudios.com
# Forked originally from the Anarchy installer: anarchyinstaller.gitlab.io
#
# shellcheck disable=SC2154,SC2155

if [[ "${iscontainer}" == 'yes' ]]; then
  readonly BUILD_DIR='/gdl'
else
  readonly BUILD_DIR="$(pwd)"
fi
readonly DEPENDENCIES=(
  'archiso'
  'cowsay'
)
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
# Arguments: A string of text to present. A second argument of '--error'
#   prepends "ERROR: " to the text and compels the dragon to attack a cow.
# Outputs: The desired message.
################################################################################
dragonsay() {
  local cowfile='dragon'

  if [[ "$2" == '--error' ]]; then
    set -- "ERROR: $1"
    cowfile+='-and-cow'
  fi
  if ! pacman -Q cowsay &>/dev/null; then
    echo "$1"
  else
    cowsay -f "${cowfile}" "$1"
  fi
}

################################################################################
# Check for given directories/files that should not yet exist.
#
# Globals: BUILD_DIR
# Arguments: Names of directories/files to check, each as a separate string.
# Returns: Number of issues found.
################################################################################
check_build_dir() {
  local -i issues=0

  for name in "$@"; do
    if [[ -e "${BUILD_DIR}/${name}" ]]; then
      dragonsay "'${name}' already exists." --error
      (( ++issues ))
    fi
  done

  return $issues
}

################################################################################
# Initialize pacman keyring, update system, and install dependencies.
#
# Globals: DEPENDENCIES
# Arguments: None.
# Returns: Number of errors detected.
################################################################################
prepare_pacman() {
  if ! pacman-key --init; then
    dragonsay "Failed to initialize pacman keyring." --error
    return 1
  elif ! pacman -Syu --noconfirm; then
    dragonsay "Failed to update system." --error
    return 1
  fi
  for dep in "${DEPENDENCIES[@]}"; do
    if ! pacman -S --needed --noconfirm "${dep}"; then
      dragonsay "Failed to install dependency '${dep}'." --error
      return 1
    fi
  done
}

################################################################################
# Prepare a custom 'profile' directory for later use by archiso.
#
# Globals: BUILD_DIR, ADDITIONAL_PACKAGES
# Arguments: None
# Returns: Number of errors detected.
################################################################################
prepare_profile_dir() {
  local package file

  # Copy archiso files to profile dir
  mkdir "${BUILD_DIR}/profile"
  cp -rT /usr/share/archiso/configs/releng "${BUILD_DIR}/profile" || return 1

  # Copy GDL files to profile dir
  cp -f "${BUILD_DIR}/profiledef.sh" "${BUILD_DIR}/profile"
  cp -f "${BUILD_DIR}/.zlogin" "${BUILD_DIR}/extra/skel/.vimrc" \
    "${BUILD_DIR}/.dialogrc" "${BUILD_DIR}/profile/airootfs/root"
  cp "${BUILD_DIR}/gdl.conf" "${BUILD_DIR}/profile/airootfs/etc"
  mkdir "${BUILD_DIR}/profile/airootfs/usr/bin"
  cp "${BUILD_DIR}/gdl" "${BUILD_DIR}/profile/airootfs/usr/bin"
  mkdir -p "${BUILD_DIR}/profile/airootfs/usr/share/gdl"
  cp -r "${BUILD_DIR}/extra" "${BUILD_DIR}/lang" \
    "${BUILD_DIR}/profile/airootfs/usr/share/gdl"
  cp -r "${BUILD_DIR}/images/icons" "${BUILD_DIR}/images/wallpapers" \
    "${BUILD_DIR}/profile/airootfs/usr/share/gdl/extra"

  # Configure pacman for a more aesthetic build process
  sed -i 's/^#Color/Color\nILoveCandy/' "${BUILD_DIR}/profile/pacman.conf"

  # Remove "message of the day"
  rm "${BUILD_DIR}/profile/airootfs/etc/motd"

  # Set installer's hostname and console font
  echo 'gdl' >"${BUILD_DIR}/profile/airootfs/etc/hostname"
  echo -e "127.0.0.1 localhost\n::1 localhost\n127.0.1.1 gdl.localdomain gdl" \
    >>"${BUILD_DIR}/profile/airootfs/etc/hosts"
  echo 'FONT=ter-v16n' >>"${BUILD_DIR}/profile/airootfs/etc/vconsole.conf"

  # Add GDL-specific packages to the package list
  for package in "${ADDITIONAL_PACKAGES[@]}"; do
    echo "${package}" >>"${BUILD_DIR}/profile/packages.x86_64"
  done

  # Customize bootloader
  for file in "${BUILD_DIR}/profile/efiboot/loader/entries/"*; do
    sed -i 's/Arch Linux install medium/GDL Arch Installer/' "${file}"
  done
  file="${BUILD_DIR}/profile/syslinux/archiso_sys-linux.cfg"
  sed -i 's/Arch Linux install medium/GDL Arch Installer/' "${file}"
  sed -i 's/Arch Linux/Arch/' "${file}"
  sed -i 's/It allows you/Allows you/' "${file}"
  file="${BUILD_DIR}/profile/syslinux/archiso_pxe-linux.cfg"
  sed -i 's/Arch Linux install medium/GDL Arch Installer/' "${file}"
  sed -i 's/Arch Linux/Arch/' "${file}"
  sed -i 's/It allows you/Allows you/' "${file}"
  file="${BUILD_DIR}/profile/syslinux/archiso_head.cfg"
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
  cp -f "${BUILD_DIR}/images/splash.png" "${BUILD_DIR}/profile/syslinux/"
}

################################################################################
# Create a GDL ISO image and associated checksum file in an 'out' directory.
#
# Globals: BUILD_DIR
# Arguments: None
# Returns: Number of errors detected.
################################################################################
generate_iso() {
  local filename

  if ! cd "${BUILD_DIR}" || ! mkarchiso -v "${BUILD_DIR}/profile"; then
    dragonsay "Unable to create ISO file." --error
    return 1
  fi
  filename="$(basename "$(find "${BUILD_DIR}/out" -name 'gdl-*.iso')")"
  if ! cd "${BUILD_DIR}/out" \
      || [[ ! -f "${filename}" ]] \
      || ! sha512sum --tag "${filename}" >"${filename}.sha512sum"; then
    dragonsay "Unable to get checksum for file '${filename}'." --error
    return 1
  fi
}

################################################################################
# Facilitate creation of a GDL ISO image and checksum file.
#
# Globals: BUILD_DIR
# Arguments: Optional '-c' to build via container.
# Outputs: New files are placed in an 'out' directory.
# Returns: Number of errors detected.
################################################################################
main() {
  if (( $(id -u) != 0 )) || [[ -n "$1" && "$1" != '-c' ]]; then # show usage
    dragonsay "Usage: sudo ./build.sh [-c]"
    return 1
  elif [[ -f "${BUILD_DIR}/out" ]]; then
    dragonsay "'out' already exists as a regular file." --error
    return 1
  elif [[ "$1" == '-c' ]] || ! pacman -V; then # set up Arch Linux container
    [[ -d "${REPO_DIR}/out" ]] || mkdir "${BUILD_DIR}/out"
    if ! podman build --rm -t gdl --no-cache -f ./Containerfile \
        || ! podman run --rm --rmi -tiv "${BUILD_DIR}/out:/gdl/out" \
          --privileged localhost/gdl; then
      dragonsay "Building via podman failed." --error
      return 1
    fi
  else # build
    check_build_dir 'profile' 'work' || return 1
    prepare_pacman || return 1
    prepare_profile_dir || return 1
    generate_iso || return 1
    rm -rf "${BUILD_DIR}/profile" "${BUILD_DIR}/work"
    dragonsay "Your Golden Drake Linux ISO is ready!"
  fi
}

main "$@"
