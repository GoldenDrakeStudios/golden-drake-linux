# ~/.bashrc

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# make colorcoding available for everyone
Black='\[\e[0;30m\]'
Red='\[\e[0;31m\]'
Green='\[\e[0;32m\]'
Yellow='\[\e[0;33m\]'
Blue='\[\e[0;34m\]'
Magenta='\[\e[0;35m\]'
Cyan='\[\e[0;36m\]'
White='\[\e[0;37m\]'
BBlack='\[\e[1;30m\]' # bold colors
BRed='\[\e[1;31m\]'
BGreen='\[\e[1;32m\]'
BYellow='\[\e[1;33m\]'
BBlue='\[\e[1;34m\]'
BMagenta='\[\e[1;35m\]'
BCyan='\[\e[1;36m\]'
BWhite='\[\e[1;37m\]'
OnBlack='\[\e[40m\]' # background colors
OnRed='\[\e[41m\]'
OnGreen='\[\e[42m\]'
OnYellow='\[\e[43m\]'
OnBlue='\[\e[44m\]'
OnMagenta='\[\e[45m\]'
OnCyan='\[\e[46m\]'
OnWhite='\[\e[47m\]'
NC='\[\e[m\]'        # "no color" (color reset)
ALERT=${BWhite}${OnRed}

# set terminal prompt
PS1="${Yellow}\u@\h: ${Red}\w \\$ ${NC}"

# simple dice-rolling function
function roll() {
  local usage="Usage: roll num_dice [num_sides=6] (e.g., 'roll 2 4' = 2d4)"
  local integer="^[0-9]+$"
  if [[ $# -ge 1 && $# -le 2 && $1 =~ $integer ]] &&
     [[ $# -eq 1 || $2 =~ $integer ]]; then
    local num_dice=$1
    local num_sides=${2:-6}
    local current_roll=0
    local total=0
    echo -ne "${num_dice}d${num_sides}:\t"
    for ((die = 0; die < num_dice; die++)); do
      current_roll=$(shuf -i 1-$num_sides -n 1)
      echo -ne "${current_roll}\t"
      total=$((total + current_roll))
    done
    echo # new line
    if [ $1 -gt 1 ]; then
      echo -e "Total:\t${total}"
    fi
  else
    echo "${usage}"
  fi
}

# create a *.tar.gz archive from a given file or directory
function maketar() { tar cvzf "${1%%/}.tar.gz" "${1%%/}/"; }

# create a *.zip archive from a given file or directory
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# extract all files from an archive into current directory
function extract {
  if [ -z "$1" ]; then
    # display usage if no parameters are given
    local ext="<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "Usage: extract <path/file_name>.${ext}"
  else
    if [ -f "$1" ] ; then
      case "$1" in
        *.tar.bz2)  tar xvjf "$1"    ;;
        *.tar.gz)   tar xvzf "$1"    ;;
        *.tar.xz)   tar xvJf "$1"    ;;
        *.lzma)     unlzma "$1"      ;;
        *.bz2)      bunzip2 "$1"     ;;
        *.rar)      unrar x -ad "$1" ;;
        *.gz)       gunzip "$1"      ;;
        *.tar)      tar xvf "$1"     ;;
        *.tbz2)     tar xvjf "$1"    ;;
        *.tgz)      tar xvzf "$1"    ;;
        *.zip)      unzip "$1"       ;;
        *.Z)        uncompress "$1"  ;;
        *.7z)       7z x "$1"        ;;
        *.xz)       unxz "$1"        ;;
        *.exe)      cabextract "$1"  ;;
        *)          echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}

# create a directory and cd into it
mcd() {
  mkdir "$1"
  cd "$1"
}

# general aliases
alias ls='ls -F --color=auto'
alias l='ls'
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -lA'
alias grep='grep --color=auto'
alias histgrep='history | grep'
alias ps='ps auxf'
alias psgrep='ps -e | grep -i'
alias vi='vim'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'
alias free='free -t'
alias df='df -T'
alias du='du -ach | sort -h'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias userlist='cut -d: -f1 /etc/passwd'
alias myip='curl ipv4.icanhazip.com'
alias youtube-dlmp3='youtube-dl --extract-audio --audio-format mp3'
alias sshtron='ssh sshtron.zachlatta.com' # https://github.com/zachlatta/sshtron
alias hacf='halt -p' # halt and catch fire

# pacman / yay
alias yayupdate='yay -Syu'
alias yayupdatemirrors='sudo reflector --verbose --latest 50 --protocol https \
  --sort rate --save /etc/pacman.d/mirrorlist && yay -Syyu'
alias yaycleanup='yay -Yc && paccache -rk1 -ruk0'
alias yaystats='yay -Ps'
alias yaylistnative='yay -Qn'
alias yaylistforeign='yay -Qm'

# cmatrix
alias cmatrix='cmatrix -bu 8'
alias cmatrixgreen='cmatrix -C green'
alias cmatrixred='cmatrix -C red'
alias cmatrixblue='cmatrix -C blue'
alias cmatrixwhite='cmatrix -C white'
alias cmatrixyellow='cmatrix -C yellow'
alias cmatrixcyan='cmatrix -C cyan'
alias cmatrixmagenta='cmatrix -C magenta'
alias cmatrixrandom='cmatrix -C $(shuf -e red green blue cyan magenta yellow \
  white -n 1)'

# cowsay
alias cowsay='cowsay -W 75'
alias cowsayborg='cowsay -b'
alias cowsaydead='cowsay -d'
alias cowsaygreedy='cowsay -g'
alias cowsayparanoid='cowsay -p'
alias cowsaystoned='cowsay -s'
alias cowsaytired='cowsay -t'
alias cowsaywired='cowsay -w'
alias cowsayyouthful='cowsay -y'
alias cowsaylion='cowsay -f moofasa'
alias cowsayskeleton='cowsay -f skeleton'
alias cowsaymutant='cowsay -f three-eyes'
alias cowsayvader='cowsay -f vader'
alias fortunecow='fortune | cowsay'
alias cowsayfrog='cowsay -f bud-frogs'
alias fortunefrog='fortune | cowsay -f bud-frogs'
alias cowsaybunny='cowsay -f bunny'
alias fortunebunny='fortune | cowsay -f bunny'
alias cowsaydragon='cowsay -f dragon'
alias dragonsay='cowsay -f dragon'
alias fortunedragon='fortune | cowsay -f dragon'
alias cowsayelephant='cowsay -f elephant'
alias fortuneelephant='fortune | cowsay -f elephant'
alias cowsaykoala='cowsay -f koala'
alias fortunekoala='fortune | cowsay -f koala'
alias cowsaymoose='cowsay -f moose'
alias fortunemoose='fortune | cowsay -f moose'
alias cowsaysheep='cowsay -f sheep'
alias fortunesheep='fortune | cowsay -f sheep'
alias cowsaystegosaurus='cowsay -f stegosaurus'
alias fortunestegosaurus='fortune | cowsay -f stegosaurus'
alias cowsayturkey='cowsay -f turkey'
alias fortuneturkey='fortune | cowsay -f turkey'
alias cowsayturtle='cowsay -f turtle'
alias fortuneturtle='fortune | cowsay -f turtle'
alias cowsaypenguin='cowsay -f tux'
alias fortunepenguin='fortune | cowsay -f tux'
alias cowsayrandom='cowsay -f $(shuf -e tux moofasa skeleton three-eyes vader \
  bud-frogs bunny dragon elephant koala moose sheep stegosaurus turkey turtle \
  -n 1)'
alias randomcow='cowsayrandom'
alias fortunerandomcow='fortune | randomcow'

# boxes
alias boxboy='boxes -d boy'
alias boxc='boxes -d c'
alias boxcc='boxes -d cc'
alias boxcat='boxes -d cat'
alias boxcolumns='boxes -d columns'
alias boxdiamonds='boxes -d diamonds'
alias boxdog='boxes -d dog'
alias boxface='boxes -d face'
alias boxfeet='boxes -d ian_jones'
alias boxfence='boxes -d fence'
alias boxgirl='boxes -d girl'
alias boxgirlcap='boxes -d capgirl'
alias boxhtml='boxes -d html'
alias boximportant='boxes -d important'
alias boximportant2='boxes -d important2'
alias boximportant3='boxes -d important3'
alias boxmouse='boxes -d mouse'
alias boxnuke='boxes -d nuke'
alias boxparchment='boxes -d parchment'
alias boxpeek='boxes -d peek'
alias boxsanta='boxes -d santa'
alias boxscroll='boxes -d scroll'
alias boxscroll2='boxes -d scroll-akn'
alias boxspring='boxes -d spring'
alias boxstone='boxes -d stone'
alias boxsunset='boxes -d sunset'
alias boxunicorn='boxes -d unicornsay'
alias boxunicornthink='boxes -d unicornthink'
alias boxtwisted='boxes -d twisted'
alias boxwhirly='boxes -d whirly'
alias boxrandom='boxes -d $(shuf -e boy c cc cat columns diamonds dog face \
  ian_jones fence girl capgirl html important mouse nuke parchment peek santa \
  scroll scroll-akn spring stone sunset unicornsay twisted whirly -n 1)'
alias randombox='boxrandom'
alias fortunerandombox='fortune | randombox'

# figlet / toilet
alias figlet='figlet -t'
alias figletbanner='figlet -f banner'
alias figletbig='figlet -f big'
alias figletblock='figlet -f block'
alias figletbubble='figlet -f bubble'
alias figletdigital='figlet -f digital'
alias figletbackwards='figlet -f ivrit'
alias figletlean='figlet -f lean'
alias figletmini='figlet -f mini'
alias figletscript='figlet -f script'
alias figletsmallscript='figlet -f smscript'
alias figletshadow='figlet -f shadow'
alias figletsmallshadow='figlet -f smshadow'
alias figletslant='figlet -f slant'
alias figletsmallslant='figlet -f smslant'
alias figletsmall='figlet -f small'
alias figletrandom='figlet -f $(find /usr/share/figlet/fonts -name *.flf |
  shuf -n 1)'
alias randomfiglet='figletrandom'
alias fortunerandomfiglet='fortune | randomfiglet'
alias toilet='toilet -t'
alias toiletbig='toilet -f bigascii9'
alias toiletsmall='toilet -f smascii9'
alias toilet12='toilet -f ascii12'
alias toilet12big='toilet -f bigascii12'
alias toilet12small='toilet -f smascii12'
alias toiletblock='toilet -f smblock'
alias toiletbraille='toilet -f smbraille'
alias toiletcircle='toilet -f circle'
alias toiletemboss='toilet -f emboss'
alias toiletemboss2='toilet -f emboss2'
alias toiletfauxcyrillic='toilet -f fauxcyrillic'
alias toiletfullcyrillic='toilet -f fullcyrillic'
alias toiletfraktur='toilet -f bfraktur'
alias toiletfuture='toilet -f future'
alias toiletletter='toilet -f letter'
alias toiletpagga='toilet -f pagga'
alias toiletmono9='toilet -f mono9'
alias toiletmono9big='toilet -f bigmono9'
alias toiletmono9small='toilet -f smmono9'
alias toiletmono12='toilet -f mono12'
alias toiletmono12big='toilet -f bigmono12'
alias toiletmono12small='toilet -f smmono12'
alias toiletterm='toilet -f term'
alias toilettermwide='toilet -f wideterm'
alias toiletrandom='toilet -f $(find /usr/share/figlet -name *.tlf |
  sed "s:/usr/share/figlet/::g" | sed "s/.tlf//g" | shuf -n 1)'
alias randomtoilet='toiletrandom'
alias fortunerandomtoilet='fortune | randomtoilet'

# lolcat (https://github.com/busyloop/lolcat)
alias lol='lla | lolcat'
alias lolacpi='acpi | lolcat -a'
alias lolblk='lsblk | lolcat'
alias lolcow='cowsay | lolcat'
alias loldf='df -h | lolcat'
alias loldragon='dragonsay | lolcat -p 0.1 -F 0.007 -S 70'
alias goldendrake='dragonsay | lolcat -p 0.1 -F 0.002 -S 320'
alias goldendrakefortune='fortune | goldendrake'
alias lolfdisk='sudo fdisk -l | lolcat'
alias lolfetch='neofetch | lolcat'
alias lolfortune='fortune | lolcat'
alias lolfree='free -h | lolcat'
alias lolgit='git status | lolcat'
alias lolparted='sudo parted -l | lolcat'
alias lolps_mem='sudo ps_mem | lolcat'
alias lolpwd='pwd | lolcat -a'
alias lolsensors='sensors | lolcat'
alias loluname='uname -a | lolcat -a'
alias lolw='w | lolcat'
alias lolwhoami='whoami | lolcat -a'
alias fiesta='lolcat -a -p 0.1 -F 50'
alias lulz='lla | fiesta'

# "No more secrets..." (https://github.com/bartobri/no-more-secrets)
alias nms='nms -a'
alias nmsl='l | nms'
alias nmsls='ls | nms'
alias nmsla='la | nms'
alias nmsll='ll | nms'
alias nmslla='lla | nms'
alias nmsacpi='acpi | nms'
alias nmsblk='lsblk | nms'
alias nmscow='cowsay | nms'
alias cowsaynms='nmscow'
alias nmsdf='df -h | nms'
alias nmsdragon='dragonsay | nms'
alias dragonsaynms='nmsdragon'
alias nmsfortune='fortune | nms'
alias fortunenms='nmsfortune'
alias nmsfree='free -h | nms'
alias nmsgit='git status | nms'
alias nmspwd='pwd | nms'
alias nmssensors='sensors | nms'
alias nmsuname='uname -a | nms'
alias nmsw='w | nms'
alias nmswhoami='whoami | nms'
