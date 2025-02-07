# ~/.bashrc
bash ~/.config/gdl-config-script & # this line disappears after first login

# if not running interactively, exit
[[ $- != *i* ]] && return

export EDITOR='vim'
export VISUAL=$EDITOR

# colors for custom terminal output
export BLACK='\e[0;30m'
export RED='\e[0;31m'
export GREEN='\e[0;32m'
export YELLOW='\e[0;33m'
export BLUE='\e[0;34m'
export MAGENTA='\e[0;35m'
export CYAN='\e[0;36m'
export WHITE='\e[0;37m'
export BOLD_BLACK='\e[1;30m'
export BOLD_RED='\e[1;31m'
export BOLD_GREEN='\e[1;32m'
export BOLD_YELLOW='\e[1;33m'
export BOLD_BLUE='\e[1;34m'
export BOLD_MAGENTA='\e[1;35m'
export BOLD_CYAN='\e[1;36m'
export BOLD_WHITE='\e[1;37m'
export ON_BLACK='\e[40m'
export ON_RED='\e[41m'
export ON_GREEN='\e[42m'
export ON_YELLOW='\e[43m'
export ON_BLUE='\e[44m'
export ON_MAGENTA='\e[45m'
export ON_CYAN='\e[46m'
export ON_WHITE='\e[47m'
export COLOR_RESET='\e[m'

# colors formatted for the terminal prompt (see PS1 below)
export BLACK2='\[\e[0;30m\]'
export RED2='\[\e[0;31m\]'
export GREEN2='\[\e[0;32m\]'
export YELLOW2='\[\e[0;33m\]'
export BLUE2='\[\e[0;34m\]'
export MAGENTA2='\[\e[0;35m\]'
export CYAN2='\[\e[0;36m\]'
export WHITE2='\[\e[0;37m\]'
export BOLD_BLACK2='\[\e[1;30m\]'
export BOLD_RED2='\[\e[1;31m\]'
export BOLD_GREEN2='\[\e[1;32m\]'
export BOLD_YELLOW2='\[\e[1;33m\]'
export BOLD_BLUE2='\[\e[1;34m\]'
export BOLD_MAGENTA2='\[\e[1;35m\]'
export BOLD_CYAN2='\[\e[1;36m\]'
export BOLD_WHITE2='\[\e[1;37m\]'
export ON_BLACK2='\[\e[40m\]'
export ON_RED2='\[\e[41m\]'
export ON_GREEN2='\[\e[42m\]'
export ON_YELLOW2='\[\e[43m\]'
export ON_BLUE2='\[\e[44m\]'
export ON_MAGENTA2='\[\e[45m\]'
export ON_CYAN2='\[\e[46m\]'
export ON_WHITE2='\[\e[47m\]'
export COLOR_RESET2='\[\e[m\]'

# set terminal prompt
PS1="${RED2}\u@\h${BLUE2}:${YELLOW2}\w${BLUE2}$ ${COLOR_RESET2}"

# simple dice-rolling function
roll() {
  local integer='^[0-9]+$'
  if (( $# >= 1 && $# <= 2 )) \
      && [[ $1 =~ ${integer} ]] \
      && ( (( $# == 1 )) || [[ $2 =~ ${integer} && $2 != 0 ]] ); then
    local -i die num_dice=$1 num_sides=${2:-6} current_roll=0 total=0
    echo -ne "${num_dice}d${num_sides}:\t"
    for (( die = 0; die < num_dice; ++die )); do
      current_roll=$(( 1 + SRANDOM % num_sides ))
      echo -ne "${current_roll}\t"
      (( total += current_roll ))
    done
    echo # new line
    if (( $1 > 1 )); then
      echo -e "Total:\t${total}"
    fi
  else
    echo "Usage: roll num_dice [num_sides=6] (e.g., 'roll 2 4' = 2d4)"
    return 1
  fi
}

# create a *.tar.xz archive from a given file or directory
maketarxz() { tar cJf "${1%%/}.tar.xz" "${1%%/}/" || return 1; }

# create a *.tar.gz archive from a given file or directory
maketargz() { tar czf "${1%%/}.tar.gz" "${1%%/}/" || return 1; }

# create a *.zip archive from a given file or directory
makezip() { zip -r "${1%%/}.zip" "$1" || return 1; }

# extract all files from a given archive into current directory
extract() {
  local usage="Usage: extract <path/filename>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z\
|xz|ex|tar.bz2|tar.gz|tar.xz>"
  if [[ -z "$1" ]]; then
    echo "${usage}"
    return 1
  elif [[ ! -f "$1" ]]; then
    echo -e "Error: '$1' does not exist or is not a regular file.\n${usage}"
    return 1
  else
    case "$1" in
      *.tar.bz2) tar xjf "$1"     ;;
      *.tar.gz)  tar xzf "$1"     ;;
      *.tar.xz)  tar xJf "$1"     ;;
      *.lzma)    unlzma "$1"      ;;
      *.bz2)     bunzip2 "$1"     ;;
      *.rar)     unrar x -ad "$1" ;;
      *.gz)      gunzip "$1"      ;;
      *.tar)     tar xf "$1"      ;;
      *.tbz2)    tar xjf "$1"     ;;
      *.tgz)     tar xzf "$1"     ;;
      *.zip)     unzip "$1"       ;;
      *.Z)       uncompress "$1"  ;;
      *.7z)      7z x "$1"        ;;
      *.xz)      unxz "$1"        ;;
      *.exe)     cabextract "$1"  ;;
      *)
        echo -e "Error: '$1' has no recognized extraction method.\n${usage}"
        return 1
        ;;
    esac
  fi
}

# create a directory and cd into it
mcd() {
  if [[ -z "$1" ]]; then
    echo "Usage: mcd <new_dir>"
    return 1
  else
    mkdir -p "$1" || return 1
    cd "$1" || return 1
  fi
}

# general aliases
alias vi='vim'
alias cp='cp -i'
alias mv='mv -i'
alias rename='rename -i'
alias free='free -t'
alias df='df -T'
alias neoduf='neofetch && duf -only local'
alias listusers='sort /etc/passwd | column -ts : -H PW -N \
  USERNAME,PW,UID,GUID,COMMENT,HOME,INTERPRETER'
alias userlist='listusers'
alias myipv4='curl ipv4.icanhazip.com'
alias myipv6='curl ipv6.icanhazip.com'
alias termbin='nc termbin.com 9999'
alias findall='sudo find / \( -path /proc -o -path /run/user \) -prune -o'
alias watchtemperatures="watch -n 1.5 exec 'sensors | grep °C'"
alias hcf='halt -p' # halt and catch fire (https://youtu.be/ucSUs3adMQ8)

# ls
alias ls='ls -F --color=auto --group-directories-first'
alias l='ls'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lhA'
alias lll='ll'
alias llla='lla'

# grep
alias grep='grep --color=auto'
alias histgrep='history | grep -i'
alias psgrep='ps -e | grep -i'
alias lsmodgrep='lsmod | grep -i'

# pacman / yay
alias yaycleanup='yay -Yc && yay -Sc --noconfirm'
alias yaylistforeign='yay -Qm'
alias yaylistnative='yay -Qn'
alias yaynews='yay -Pw'
alias yaynewsall='yay -Pww'
alias yaystats='yay -Ps'
alias yayup='yaynews && yay'
alias updatemirrors='sudo reflector --verbose --latest 50 --protocol https \
  --sort rate --save /etc/pacman.d/mirrorlist && yayup'

# grub
alias updategrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias grubupdate='updategrub'
alias reinstallgrub=''
alias grubreinstall='reinstallgrub'

# xclip
alias xclipcopy='xclip -selection clipboard'
alias xclippaste='xclip -out -selection clipboard'

# yt-dlp
alias yt-dlpmp3='yt-dlp -x --audio-format mp3'
alias yt-dlpogg='yt-dlp -x --audio-format vorbis'

# cmatrix
alias cmatrix='cmatrix -bu 8'
alias cmatrixred='cmatrix -C red'
alias cmatrixgreen='cmatrix -C green'
alias cmatrixblue='cmatrix -C blue'
alias cmatrixcyan='cmatrix -C cyan'
alias cmatrixmagenta='cmatrix -C magenta'
alias cmatrixyellow='cmatrix -C yellow'
alias cmatrixwhite='cmatrix -C white'
alias cmatrixrandom='cmatrix -C "$(shuf -e red green blue cyan magenta yellow \
  white -n 1)"'

# cbonsai
cbonsaileaves() {
  local text="$*"
  [[ -z "${text}" ]] && read -r text
  cbonsai -Sm "${text}" -c "$(echo "${text}" | tr '[:space:]' ',')"
}
cbonsaifortune() { cbonsai -Sm "$(fortune)"; }
cbonsaifortuneleaves() { cbonsaileaves "$(fortune)"; }

# cowsay
alias cowsayborg='cowsay -b'
alias cowsaydead='cowsay -d'
alias cowsaygreedy='cowsay -g'
alias cowsayparanoid='cowsay -p'
alias cowsaystoned='cowsay -s'
alias cowsaytired='cowsay -t'
alias cowsaywired='cowsay -w'
alias cowsayyouthful='cowsay -y'
alias cowsaybeavis='cowsay -f beavis.zen'
alias cowsayblowfish='cowsay -f blowfish'
alias cowsaybong='cowsay -f bong'
alias cowsaybunny='cowsay -f bunny'
alias cowsaycheese='cowsay -f cheese'
alias cowsaycower='cowsay -f cower'
alias cowsaydaemon='cowsay -f daemon'
alias cowsaydragon='cowsay -f dragon'
alias dragonsay='cowsay -f dragon'
alias dragonthink='cowthink -f dragon'
alias cowsaydragonandcow='cowsay -f dragon-and-cow'
alias cowsayelephant='cowsay -f elephant'
alias cowsayeyes='cowsay -f eyes'
alias cowsayfrogs='cowsay -f bud-frogs'
alias cowsayghostbusters='cowsay -f ghostbusters'
alias cowsaykiss='cowsay -f kiss'
alias cowsaykitty='cowsay -f hellokitty'
alias cowsaykoala='cowsay -f koala'
alias cowsaykoalaluke='cowsay -f luke-koala'
alias cowsaykoalavader='cowsay -f vader-koala'
alias cowsaylion='cowsay -f moofasa'
alias cowsaymilk='cowsay -f milk'
alias cowsaymoose='cowsay -f moose'
alias cowsaymutant='cowsay -f three-eyes'
alias cowsaypanther='cowsay -f kitty'
alias cowsaypenguin='cowsay -f tux'
alias cowsayren='cowsay -f ren'
alias cowsaysheep='cowsay -f sheep'
alias cowsaysheepflaming='cowsay -f flaming-sheep'
alias cowsaysmall='cowsay -f small'
alias cowsayskeleton='cowsay -f skeleton'
alias cowsaystegosaurus='cowsay -f stegosaurus'
alias cowsaystimpy='cowsay -f stimpy'
alias cowsaytiger='cowsay -f meow'
alias cowsayturkey='cowsay -f turkey'
alias cowsayturtle='cowsay -f turtle'
alias cowsayudder='cowsay -f udder'
alias cowsayvader='cowsay -f vader'
alias cowsayrandom='cowsay -f "$(shuf -e beavis.zen blowfish bong bud-frogs \
  bunny cheese cower daemon default dragon dragon-and-cow elephant eyes \
  flaming-sheep ghostbusters hellokitty kiss kitty koala luke-koala meow milk \
  moofasa moose ren sheep skeleton stegosaurus stimpy small three-eyes turkey \
  turtle tux udder vader vader-koala -n 1)"'
alias randomcow='cowsayrandom'

# boxes
alias boxesboy='boxes -d boy'
alias boxesc='boxes -d c'
alias boxescc='boxes -d cc'
alias boxescat='boxes -d cat'
alias boxescolumns='boxes -d columns'
alias boxesdiamonds='boxes -d diamonds'
alias boxesdog='boxes -d dog'
alias boxesface='boxes -d face'
alias boxesfeet='boxes -d ian_jones'
alias boxesfence='boxes -d fence'
alias boxesgirl='boxes -d girl'
alias boxesgirlcap='boxes -d capgirl'
alias boxeshtml='boxes -d html'
alias boxesimportant='boxes -d important'
alias boxesimportant2='boxes -d important2'
alias boxesimportant3='boxes -d important3'
alias boxesmouse='boxes -d mouse'
alias boxesnuke='boxes -d nuke'
alias boxesparchment='boxes -d parchment'
alias boxespeek='boxes -d peek'
alias boxessanta='boxes -d santa'
alias boxesscroll='boxes -d scroll'
alias boxesscroll2='boxes -d scroll-akn'
alias boxesspring='boxes -d spring'
alias boxesstone='boxes -d stone'
alias boxessunset='boxes -d sunset'
alias boxesunicorn='boxes -d unicornsay'
alias boxesunicornthink='boxes -d unicornthink'
alias boxestwisted='boxes -d twisted'
alias boxeswhirly='boxes -d whirly'
alias boxesrandom='boxes -d "$(shuf -e boy c cc cat columns diamonds dog face \
  ian_jones fence girl capgirl html important mouse nuke parchment peek santa \
  scroll scroll-akn spring stone sunset unicornsay twisted whirly -n 1)"'
alias randombox='boxrandom'

# figlet
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
alias figletrandom='figlet -f "$(find /usr/share/figlet/fonts -name *.flf \
  | shuf -n 1)"'
alias randomfiglet='figletrandom'

# toilet
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
alias toiletrandom='toilet -f "$(find /usr/share/figlet -name *.tlf \
  | sed "s:/usr/share/figlet/::g" \
  | sed "s/.tlf//g" \
  | shuf -n 1)"'
alias randomtoilet='toiletrandom'

# lolcat (https://github.com/busyloop/lolcat)
alias lol='lla | lolcat'
alias lolacpi='acpi | lolcat -a'
alias lolblk='lsblk -o +FSTYPE,FSAVAIL,FSUSED,FSUSE% | lolcat'
alias lolcow='cowsay | lolcat'
alias loldf='df -h | lolcat'
alias loldragon='dragonsay | lolcat -p 0.1 -F 0.007 -S 70'
alias goldendrake='dragonsay | lolcat -p 0.1 -F 0.002 -S 320'
alias lolduf='neofetch | lolcat && duf -only local'
alias lolfdisk='sudo fdisk -l | lolcat'
alias lolfetch='neofetch | lolcat'
alias lolfindmnt='findmnt | lolcat'
alias lolfortune='fortune | lolcat'
alias lolfree='free -h | lolcat'
alias lolgit='git status | lolcat'
alias lolid='id | lolcat'
alias lolparted='sudo parted -l | lolcat'
alias lolps_mem='sudo ps_mem | lolcat'
alias lolsensors='sensors | lolcat'
alias loluname='uname -a | lolcat -a'
alias lolusers='listusers | lolcat'
alias lolw='w | lolcat'

# "No more secrets..." (https://github.com/bartobri/no-more-secrets)
alias nmsl='l | nms'
alias nmsls='ls | nms'
alias nmsla='la | nms'
alias nmsll='ll | nms'
alias nmslla='lla | nms'
alias nmsacpi='acpi | nms'
alias nmsblk='lsblk | nms'
alias nmscow='cowsay | nms'
alias nmsdf='df -h | nms'
alias nmsdragon='dragonsay | nms'
alias nmsfortune='fortune | nms'
alias nmsfree='free -h | nms'
alias nmsgit='git status | nms'
alias nmssensors='sensors | nms'
alias nmsuname='uname -a | nms'
alias nmsw='w | nms'
