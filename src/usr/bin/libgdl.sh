#!/usr/bin/env bash
# Library of general functions for all GDL scripts

dragonsay() {
  cowsay -W 75 -f dragon "$1"
}

# Logging library, that appends its arguments (log messages) to the LOG_FILE
log() {
  if [ -n "$1" ]; then
    # Manual logging
    message="$1"
    echo "[$(date '+%H:%M:%S')]: ${message}" >>"${LOG_FILE}"
  else
    # Command output
    echo "*** COMMAND OUTPUT ***" >>"${LOG_FILE}"
    while read -r message; do
      echo "${message}" >>"${LOG_FILE}"
    done
    echo "*** END OF COMMAND OUTPUT ***" >>"${LOG_FILE}"
  fi
}

# Enable systemd services
enable_service() {
  arch-chroot /mnt systemctl enable "$1"
  log "Enabled systemd service: $1"
}

# Check for an internet connection; if not found, connect to Wi-Fi
check_connection() {
  if ! nc -zw1 1.1.1.1 443; then
    nmtui
  fi
}

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

# Puts off or on some dialog field
offon() {
  [[ "$2" == *"$1"* ]] && printf "on" || printf "off"
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

# Automatically upload log to termbin and print info to user on fatal error
report_error() {
  log "Installation failed, uploading log to termbin.com"
  log_url="$(nc termbin.com 9999 </root/gdl.log)"
  msg "\n${failed_msg} ${log_url}"
}

# Function for handling a sudden exit when the user presses CTRL+C
force_quit() {
  log "User force quit the installation"
  op_title="Force Quit"
  msg "\n${force_quit_msg}"
  clear
  dragonsay "${how_to_relaunch_installer}"
  exit 1
}
