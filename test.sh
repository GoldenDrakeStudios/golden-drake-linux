#!/bin/bash
#
# Script for testing certain features of the Golden Drake Linux (GDL) installer.
#
# Copyright (C) 2025 Golden Drake Studios: goldendrakestudios.com
#
# shellcheck disable=SC2076,SC2155

# shellcheck source=gdl.conf
source gdl.conf || exit 1
# shellcheck source=lang/english.conf
source lang/english.conf || exit 1

declare -i ISSUES=0
declare -ri OFFICIAL=0
declare -ri AUR=1
declare -ri MAX_LINE_LEN=80
declare -ri MAX_SOFTWARE_DESC_LEN=74
declare -ri LANG_FILE_NUM_LINES=$(wc -l lang/english.conf | awk '{print $1}')
declare -ra SHELL_FILES=(
  'test.sh'
  'build.sh'
  'gdl'
  'gdl.conf'
  'profiledef.sh'
  '.zlogin'
  'extra/skel/.bashrc'
  'extra/skel/.xprofile'
  'extra/skel/.config/gdl-config-script'
  'lang/bulgarian.conf'
  'lang/dutch.conf'
  'lang/english.conf'
  'lang/french.conf'
  'lang/german.conf'
  'lang/greek.conf'
  'lang/hungarian.conf'
  'lang/indonesian.conf'
  'lang/italian.conf'
  'lang/latvian.conf'
  'lang/lithuanian.conf'
  'lang/polish.conf'
  'lang/portuguese-brazil.conf'
  'lang/portuguese.conf'
  'lang/romanian.conf'
  'lang/russian.conf'
  'lang/spanish.conf'
  'lang/swedish.conf'
)
declare -ra PACKAGE_LISTS=(
  'BASE_PACKAGES'
  'AUR_PACKAGES'
  'WINE_PACKAGES'
  'DESKTOP_ENV_PACKAGES'
  'DESKTOP_ENV_AUR_PACKAGES'
  'MISC_PACKAGES'
  'MISC_AUR_PACKAGES'
  'GPU_PACKAGES'
  'IGPU_PACKAGES'
  'CPU_PACKAGES'
  'VM_GUEST_PACKAGES'
  'FS_PACKAGES'
  'OPTIONAL_SOFTWARE_LISTS'
)

################################################################################
# Test a given shell file (assumed to be Bash or similar) via shellcheck. For
# language files, also check number of lines and software description lengths.
# For all other files, check line lengths.
#
# Globals: MAX_LINE_LEN, MAX_SOFTWARE_DESC_LEN, LANG_FILE_NUM_LINES, ISSUES
# Arguments: Name of a shell file.
# Outputs: Descriptions of any detected issues.
################################################################################
test_shell_file() {
  local -i line_len line_num num_lines

  if [[ -f "$1" ]]; then
    shellcheck -x --shell=bash "$1" || (( ++ISSUES ))
    if [[ "$1" =~ lang ]]; then
      while read -r line; do
        line_len=$(( $(echo "${line#*=\"}" | awk '{print length}') - 1 ))
        if (( line_len > MAX_SOFTWARE_DESC_LEN )); then
          line_num=$(sed -n "/${line}/=" "$1")
          echo -e "\tLine ${line_num} desc. length: ${line_len}"
          (( ++ISSUES ))
        fi
      done < <(grep ^SOFTWARE "$1")
      num_lines=$(wc -l "$1" | awk '{print $1}')
      if (( num_lines != LANG_FILE_NUM_LINES )); then
        echo -e "\tFound ${num_lines} lines, expected ${LANG_FILE_NUM_LINES}"
        (( ++ISSUES ))
      fi
    else
      line_num=1
      while read -r line; do
        line_len=$(echo "${line}" | awk '{print length}')
        if (( line_len > MAX_LINE_LEN )); then
          echo -e "\tLine ${line_num} length: ${line_len}"
          (( ++ISSUES ))
        fi
        (( ++line_num ))
      done < <(cat "$1")
    fi
  else
    echo -e "\tERROR! File not found: $1"
    (( ++ISSUES ))
  fi
}

################################################################################
# Test a given list of packages to ensure they exist in official Arch Linux
# repos (or the AUR in some cases). For "optional software" lists, which begin
# with a title (category name), language files are also checked for existence of
# relevant variables and to ensure descriptions for AUR (and only AUR) software
# include an "(AUR)" label.
#
# Globals: OFFICIAL, AUR, ISSUES, and relevant language file globals
# Arguments: A string of package names. Also '--aur' to indicate packages should
#   be in the AUR or '--optional' for special handling of an "optional" list.
# Outputs: Descriptions of any issues detected or changes made (language files
#   may be modified to fix AUR-labeling of software descriptions).
################################################################################
test_package_list() {
  local list desc_var
  local -i repo

  list="$(tr <<<"$1" ' ' '\n' | sort | uniq | tr '\n' ' ')"
  for package in ${list}; do
    if [[ "${package}" =~ TITLE ]]; then
      if [[ -z "${!package}" ]]; then
        echo -e "\tERROR! Missing title variable: ${package}"
        (( ++ISSUES ))
      fi
      continue
    fi
    if (pacman -Si "${package}" || pacman -Sg "${package}") &>/dev/null; then
      repo=$OFFICIAL
    elif yay -Si "${package}" &>/dev/null; then
      repo=$AUR
    else
      echo -e "\tERROR! Missing package: ${package}"
      (( ++ISSUES ))
      continue
    fi
    case "$2" in
      --optional)
        desc_var="SOFTWARE_${package@U}"
        desc_var="${desc_var//-/_}"
        if [[ -z "${!desc_var}" ]]; then
          echo -e "\tERROR! Missing description variable: ${desc_var}"
          (( ++ISSUES ))
        elif (( repo == AUR )) \
            && [[ -n "${!desc_var}" && ! "${!desc_var}" =~ '(AUR)' ]]; then
          echo -e "\tAdding '(AUR) ' to ${desc_var}..."
          sed -i "s/${desc_var}=\"/&(AUR) /" lang/*
        elif (( repo == OFFICIAL )) \
            && [[ -n "${!desc_var}" && "${!desc_var}" =~ '(AUR)' ]]; then
          echo -e "\tRemoving '(AUR) ' from ${desc_var}..."
          sed -i "s/${desc_var}=\"(AUR) /${desc_var}=\"/" lang/*
        fi
        ;;
      --aur)
        if (( repo != AUR )); then
          echo -e "\tERROR! Move ${package} to non-AUR list"
          (( ++ISSUES ))
        fi
        ;;
      *)
        if (( repo == AUR )); then
          echo -e "\tERROR! Move ${package} to AUR list"
          (( ++ISSUES ))
        fi
        ;;
    esac
  done
}

################################################################################
# Facilitate testing of certain GDL files and variables.
#
# Globals: SHELL_FILES, PACKAGE_LISTS, and all package globals from gdl.conf
# Arguments: None
# Outputs: Descriptions of files/lists tested and issues detected.
################################################################################
main() {
  local cowfile='dragon' message='All tests complete! Issues: '

  echo "Testing shell files..."
  for shell_file in "${SHELL_FILES[@]}"; do
    echo "- File: ${shell_file}"
    test_shell_file "${shell_file}"
  done

  echo -e "\nTesting package lists..."
  for list in "${PACKAGE_LISTS[@]}"; do
    echo "- List: ${list}"
    case "${list}" in
      *ENV_P*) test_package_list "${DESKTOP_ENV_PACKAGES[*]}" ;;
      *ENV_A*) test_package_list "${DESKTOP_ENV_AUR_PACKAGES[*]}" --aur ;;
      MISC_P*) test_package_list "${MISC_PACKAGES[*]}" ;;
      MISC_A*) test_package_list "${MISC_AUR_PACKAGES[*]}" --aur ;;
      GPU*)
        test_package_list "${!GPU_PACKAGES[*]}"
        test_package_list "${GPU_PACKAGES[*]}"
        ;;
      IGPU*) test_package_list "${IGPU_PACKAGES[*]}" ;;
      CPU*) test_package_list "${CPU_PACKAGES[*]}" ;;
      VM*) test_package_list "${VM_GUEST_PACKAGES[*]}" ;;
      FS*) test_package_list "${FS_PACKAGES[*]}" ;;
      OPTIONAL*)
        for optional_list in "${OPTIONAL_SOFTWARE_LISTS[@]}"; do
          test_package_list "${optional_list}" --optional
        done
        ;;
      *AUR*) test_package_list "${!list}" --aur ;;
      *) test_package_list "${!list}" ;;
    esac
  done

  message+="$ISSUES"
  (( ISSUES > 0 )) && cowfile+='-and-cow'
  if ! pacman -Q cowsay &>/dev/null; then
    echo "${message}"
  else
    cowsay -f "${cowfile}" "${message}"
  fi
}

main
