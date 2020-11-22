#!/usr/bin/env bash

################################################################################
# Golden Drake Linux: load.sh
#
# Copyright (c) 2020 Golden Drake Studios https://goldendrakestudios.com
#
# Forked from Anarchy https://gitlab.com/anarchyinstaller
#
# License: GPL v2.0
################################################################################

# Shellcheck disable warning about variables being referenced but not assigned.
#shellcheck disable=2154

cal_rate() {
    case "${connection_rate}" in
        KB/s)
            down_sec=$(echo "${download_size}*1024/${connection_speed}" | bc) ;;
        MB/s)
            down_sec=$(echo "${download_size}/${connection_speed}" | bc) ;;
        *)
            down_sec="1" ;;
    esac
    down=$(echo "${down_sec}/100+${cpu_sleep}" | bc)
    down_min=$(echo "${down}*100/60" | bc)
    if ! (<<<"${down}" grep "^[1-9]" &> /dev/null); then
        down=3
        down_min=5
    fi
    export down down_min
    source "${lang_file}"
}

load() {
    {	int="1"
            while ps | grep "${pid}" &> /dev/null
                do
                    sleep "${pri}"
                    echo "${int}"
                    if [ "${int}" -lt "100" ]; then
                        int=$((int+1))
                    fi
                done
            echo 100
            sleep 1
    } | dialog --gauge "${msg}" 9 79 0
}

load_log() {
    {	int=1
        pos=1
        pri=$((pri*2))
        while ps | grep "${pid}" &> /dev/null
            do
                sleep 0.5
                if [[ "${pos}" -eq "${pri}" ]] && [[ "${int}" -lt "100" ]]; then
                    pos=0
                    int=$((int+1))
                fi
                log_msg=$(tail -1 "${log}" | sed 's/.pkg.tar.xz//')
                echo "${int}"
                echo -e "XXX${msg} \n \Z1> \Z2${log_msg}\Zn\nXXX"
                pos=$((pos+1))
            done
            echo 100
            sleep 1
    } | dialog --gauge "${msg}" 10 79 0
}
