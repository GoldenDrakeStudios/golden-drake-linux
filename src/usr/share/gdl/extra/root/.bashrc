# ~/.bashrc

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=vim
export VISUAL="$EDITOR"

# colors for creating custom terminal output
Black='\e[0;30m'
Red='\e[0;31m'
Green='\e[0;32m'
Yellow='\e[0;33m'
Blue='\e[0;34m'
Magenta='\e[0;35m'
Cyan='\e[0;36m'
White='\e[0;37m'
BBlack='\e[1;30m' # bold colors
BRed='\e[1;31m'
BGreen='\e[1;32m'
BYellow='\e[1;33m'
BBlue='\e[1;34m'
BMagenta='\e[1;35m'
BCyan='\e[1;36m'
BWhite='\e[1;37m'
On_Black='\e[40m' # background colors
On_Red='\e[41m'
On_Green='\e[42m'
On_Yellow='\e[43m'
On_Blue='\e[44m'
On_Magenta='\e[45m'
On_Cyan='\e[46m'
On_White='\e[47m'
NC='\e[m'         # "no color" (color reset)
ALERT=${BWhite}${On_Red}

# colors formatted for the terminal prompt (see PS1 below)
Black2='\[\e[0;30m\]'
Red2='\[\e[0;31m\]'
Green2='\[\e[0;32m\]'
Yellow2='\[\e[0;33m\]'
Blue2='\[\e[0;34m\]'
Magenta2='\[\e[0;35m\]'
Cyan2='\[\e[0;36m\]'
White2='\[\e[0;37m\]'
BBlack2='\[\e[1;30m\]' # bold colors
BRed2='\[\e[1;31m\]'
BGreen2='\[\e[1;32m\]'
BYellow2='\[\e[1;33m\]'
BBlue2='\[\e[1;34m\]'
BMagenta2='\[\e[1;35m\]'
BCyan2='\[\e[1;36m\]'
BWhite2='\[\e[1;37m\]'
OnBlack2='\[\e[40m\]'  # background colors
OnRed2='\[\e[41m\]'
OnGreen2='\[\e[42m\]'
OnYellow2='\[\e[43m\]'
OnBlue2='\[\e[44m\]'
OnMagenta2='\[\e[45m\]'
OnCyan2='\[\e[46m\]'
OnWhite2='\[\e[47m\]'
NC2='\[\e[m\]'         # "no color" (color reset)

# set terminal prompt
PS1="${Red2}\u@\h${Blue2}:${Yellow2}\w${Blue2}\$ ${NC2}"

# aliases
alias ls='ls -F --color=auto'
alias l='ls'
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -lA'
alias grep='grep --color=auto'
alias histgrep='history | grep'
alias psgrep='ps -e | grep -i'
alias vi='vim'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'
alias free='free -t'
alias df='df -T'
alias du='du -ach | sort -h'
alias update-grub='grub-mkconfig -o /boot/grub/grub.cfg'
alias userlist='cut -d: -f1 /etc/passwd'
alias myip='curl ipv4.icanhazip.com'
