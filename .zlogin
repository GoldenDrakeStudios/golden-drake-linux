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
alias histgrep='history | grep -i'
alias psgrep='ps -e | grep -i'
alias lspcigrep='lspci -k | grep -i'
alias vi='vim'
alias cp='cp -i'
alias mv='mv -i'
alias rename='rename -i'
alias free='free -t'
alias df='df -T'
alias myip='curl ipv4.icanhazip.com'
alias myipv6='curl ipv6.icanhazip.com'
alias updategrub='arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg'

# custom functions to help avoid issues during reboot/poweroff
reboot() {
  __unmount_and_close_everything
  halt --reboot
}
poweroff() {
  __unmount_and_close_everything
  halt --poweroff
}
__unmount_and_close_everything() {
  local -i attempts=0 max_attempts=3
  echo '
 _________________________
/\                        \
\_|  Thank you for using  |
  |  Golden Drake Linux!  |
  |   ____________________|_
   \_/______________________/
'
  sleep 0.6
  cd / # ensure working directory isn't on /mnt
  while [[ -n $(swapon --show) ]] && (( attempts < max_attempts )); do
    swapoff -av
    sleep 0.6
    (( ++attempts ))
  done
  attempts=0
  while lsblk | grep -q '/mnt' && (( attempts < max_attempts )); do
    umount -Rv /mnt
    sleep 0.6
    (( ++attempts ))
  done
  attempts=0
  while [[ ! $(dmsetup ls) =~ ^No ]] && (( attempts < max_attempts )); do
    for device in $(dmsetup ls | awk '{print $1}' | sort -r); do
      cryptsetup close "${device}" && echo "${device} successfully closed"
      sleep 0.6
    done
    (( ++attempts ))
  done
  sleep 0.6
}

# run installer script at login
gdl
