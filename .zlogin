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
alias grep='grep --color=auto'
alias histgrep='history | grep'
alias psgrep='ps -e | grep -i'
alias vi='vim'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'
alias free='free -t'
alias df='df -T'
alias du='du -ach'

# run installer script at login
gdl
