#!/usr/bin/env bash

################################################################################
# GoldenDrakeLinux: gdl-installer.sh
#
# Main installation script. Calls all other scripts.
#
# Copyright (c) 2020 Golden Drake Studios https://goldendrakestudios.com
#
# Forked from Anarchy, copyright (c) 2017 Dylan Schacht https://anarchylinux.org
#
# License: GPL v2.0
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
# Street, Fifth Floor, Boston, MA  02110-1301, USA.
################################################################################

# Disable warning about unassigned variables (since they're in other files)
# shellcheck disable=SC2154

init() {
    if [[ $(basename "$0") = "gdl" ]]; then
        gdl_directory="/usr/share/gdl" # prev: aa_dir
        gdl_config="/etc/gdl.conf" # prev: aa_conf
        gdl_scripts="/usr/lib/gdl" # prev: aa_lib
    else
        gdl_directory=$(dirname "$(readlink -f "$0")") # GDL git repository
        gdl_config="${gdl_directory}"/etc/gdl.conf
        gdl_scripts="${gdl_directory}"/lib
    fi
    trap '' 2
    for script in "${gdl_scripts}"/*.sh ; do
        [[ -e "${script}" ]] || break
        # shellcheck source=/usr/lib/gdl/*.sh
        source "${script}"
    done
    # shellcheck source=/etc/gdl.conf
    source "${gdl_config}"
    language
    # shellcheck source=/usr/share/gdl/lang
    source "${lang_file}" # /lib/language.sh:43-60
    export reload=true
}

main() {
    set_keys
    update_mirrors
    check_connection
    set_locale
    set_zone
    prepare_drives
    install_options
    set_hostname
    set_user
    add_software
    install_base
    configure_system
    add_user
    reboot_system
}

dialog() {
    # If terminal height is more than 25 lines add a backtitle
    if "${screen_h}" ; then # /etc/gdl.conf:62
        if "${LAPTOP}" ; then # /etc/gdl.conf:75
            # Show battery life next to GDL heading
            backtitle="${backtitle} $(acpi)"
        fi
        # op_title is the current menu title
        /usr/bin/dialog --colors --backtitle "${backtitle}" --title "${op_title}" "$@"
    else
        # title is the main title (Golden Drake Linux)
        /usr/bin/dialog --colors --title "${title}" "$@"
    fi
}

if [[ "${UID}" -ne "0" ]]; then
    echo "Error: gdl-installer requires root privilege"
    echo "       Use: sudo gdl-installer"
    exit 1
fi

# Read optional arguments
opt="$1" # /etc/gdl.conf:105
init
main

# vim: ai:ts=4:sw=4:et
