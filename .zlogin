# fix for screen readers
if grep -q 'accessibility=' /proc/cmdline; then
  setopt SINGLE_LINE_ZLE
fi

~/.automated_script.sh

alias installer='gdl'
alias ls='ls -F --color=auto --group-directories-first'
alias l='ls'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lhA'
alias lll='ll'
alias llla='lla'
alias grep='grep --color=auto'
alias histgrep='history | grep'
alias psgrep='ps -e | grep -i'
alias vi='vim'
alias cp='cp -i'
alias mv='mv -i'
alias rename='rename -i'
alias mkdir='mkdir -pv'
alias free='free -t'
alias df='df -T'
alias du='du -ach'
alias updategrub='arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg'
alias myip='curl ipv4.icanhazip.com'

# custom functions to help avoid disk issues at reboot/poweroff
function reboot() {
  __unmount_and_close_everything
  halt --reboot
}
function poweroff() {
  __unmount_and_close_everything
  halt --poweroff
}
function __unmount_and_close_everything() {
  local -i attempts=0 max_attempts=3
  echo "Please wait..."
  while [[ -n $(swapon --show) ]] && (( attempts < max_attempts )); do
    swapoff -av && echo "Swap successfully deactivated"
    sleep 0.7
    (( ++attempts ))
  done
  attempts=0
  while lsblk | grep -q '/mnt' && (( attempts < max_attempts )); do
    umount -Rv /mnt && echo "Everything under /mnt successfully unmounted"
    sleep 0.7
    (( ++attempts ))
  done
  attempts=0
  while [[ $(dmsetup ls) != 'No devices found' ]] &&
        (( attempts < max_attempts )); do
    for device in $(dmsetup ls | awk '{print $1}'); do
      __close_encrypted_device "${device}"
      __close_encrypted_device "lvm-${device}"
      __close_encrypted_device "lvm-lv${device}"
      (( ++attempts ))
    done
  done
  echo "
 _______________________
/\                      \\
\_| Thank you for using |
  | Golden Drake Linux! |
  |   __________________|_
   \_/____________________/"
  sleep 2
}
function __close_encrypted_device() {
  [[ -n "$1" ]] && lsblk | grep -q "$1" && cryptsetup close "$1" &&
    echo "Encrypted device $1 successfully closed" && sleep 0.7
}

# run installer script at login
gdl
