#!/bin/bash
#
# Library of general functions for all GDL scripts.

# Custom cowsay function
dragonsay() {
  if "${USING_SCREEN_READER}"; then
    echo -e "$1\n"
  else
    cowsay -W 75 -f dragon "$1"
  fi
}

# Appends a given string or command output stream to the log file
log() {
  if [ -n "$1" ]; then
    # Manual logging
    message="$1"
    echo "[$(date '+%H:%M:%S')]: ${message}" >>"${LOG_FILE}"
  else
    # Command output
    while read -r message; do
      echo "${message}" >>"${LOG_FILE}"
    done
  fi
}

# Enables a given systemd service
enable_service() {
  arch-chroot /mnt systemctl enable "$1"
  if [ "$?" -gt "0" ]; then
    log "ERROR! Unable to enable systemd service: $1"
  else
    log "Enabled systemd service: $1"
  fi
}

# Checks for an internet connection; if not found, attempts to connect to Wi-Fi
check_connection() {
  if ! nc -zw1 1.1.1.1 443; then
    nmtui
  fi
}

# Custom dialog function
dialog() {
  if "${SCREEN_HEIGHT_SUFFICIENT}"; then
    if "${LAPTOP}"; then
      backtitle+=" | Battery: $(cat /sys/class/power_supply/BAT*/capacity)%"
    fi
    # 'op_title' is the current operation's title
    /usr/bin/dialog --colors --backtitle "${backtitle}" --title " ${op_title} "\
      "$@"
  else
    # 'title' is GDL's main title
    /usr/bin/dialog --colors --title " ${title} " "$@"
  fi
}

# Displays a message dialog
msg() {
  _body="$1"
  dialog --ok-button "${ok}" --msgbox "${_body}" 10 60
}

# Displays a yes/no dialog
yesno() {
  _body="$1"
  _yes_button="$2"
  _no_button="$3"
  if [ $# = 4 ]; then
    dialog --defaultno --yes-label "${_yes_button}" --no-label \
      "${_no_button}" --yesno "${_body}" 0 0
  else
    dialog --yes-label "${_yes_button}" --no-label "${_no_button}" \
      --yesno "${_body}" 0 0
  fi
  return $?
}

# Displays a gauge (loading bar) dialog
load() {
  {
    int='1'
    while ps | grep "${pid}" &>/dev/null; do
      sleep "${pri}"
      echo "${int}"
      if [ "${int}" -lt 100 ]; then
        int="$((int + 1))"
      fi
    done
    echo 100
    sleep 1
  } | dialog --gauge "${msg}" 9 79 0
}

# Uploads log to termbin and informs user of fatal error
report_error() {
  log "Installation failed, uploading log to termbin.com"
  log_url="$(nc termbin.com 9999 </root/gdl.log)"
  msg "\n${failed_msg} ${log_url}"
}

# Handles a sudden exit caused by the user pressing Ctrl+C
force_quit() {
  log "User force quit the installation"
  op_title="Force Quit"
  msg "\n${force_quit_msg}"
  clear
  dragonsay "${shell_prompt_msg1}"
  echo -e "${shell_prompt_msg2}"
  exit 1
}
