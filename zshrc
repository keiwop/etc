#!/usr/bin/zsh
################################################################################
################################################################################
#alias keiwop='echo \'Maxime Martin\''
#licenses=(BSDv3+ WTFPLv2+)

################################################################################
################################################################################
autoload -Uz compinit promptinit

compinit
promptinit
prompt walters

autoload -U colors && colors
zmodload zsh/net/tcp
#'\ue0b0'
#
PROMPT="%{$fg_bold[green]%}%#%{$fg_bold[cyan]%}%1~%{$fg_bold[magenta]%}❯%{$reset_color%}%"
RPROMPT="%{$fg_bold[green]%}%~ %{$fg[magenta]%}- %{$fg_bold[cyan]%}%n%{$fg_bold[magenta]%}:%{$fg[cyan]%}%m%{$fg[magenta]%}:%{$fg[blue]%}%l %{$fg[magenta]%}- %{$fg_bold[white]%}%T %{$fg[magenta]%}- %{$fg_bold[yellow]%}[%?]%{$reset_color%}"

################################################################################
################################################################################
setopt completealiases
unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD

zstyle ':completion:*' completer _expand_alias _complete _approximate _ignored _expand _correct
zstyle ':completion:*' list-colors ''
zstyle ':prompt:grml:left:setup' items rc virtual-env change-root user at host path vcs percent
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' list-separator 'fREW'
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'
zstyle ':completion:*' ignore-parents parent pwd

zstyle :compinstall filename '/home/keiwop/.zshrc'

################################################################################
################################################################################
typeset -U path

_0="/_"

path=($path /usr/share/java/javacc-5.0/bin)

path=($path /bin $_0/bin $_0/src/scripts $_0/src/python $_0/dev/keyboard/bin $_0/src/python/nameless_term )
ld_library_path=($ld_library_path $_0/lib $_0/dev/keyboard/bin/lib)

cdpath=($_0)

CLASSPATH=($CLASSPATH /usr/share/java/junit.jar /usr/share/java/javacc-5.0/bin/lib/javacc.jar)

################################################################################
################################################################################
alias -g '...'='../..'
alias -g '....'='../../..'
alias -g '.....'='../../../..'

alias -g ll='ls -lhpF --color=auto'
alias -g lll='ll -CR'
alias -g la='ll -a'

alias -g cdf='cd /_/src/fac/M1'
alias -g cd.='cd ..'
alias -g cd..='cd ...'
alias -g cd...='cd ....'

alias -g mkd='mkdir_cd'

alias -g top10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

alias -g prog_32u4='avrdude -v -v -v -v -D -P/dev/ttyACM0 -cavr109 -b57600 -patmega32u4 -Uflash:w:firmware:i'

alias -g rs="rsync -av --progress --inplace --rsh='ssh -p42'"
alias -g rs2="rsync -avxS --progress"

alias -g mountt="mount | column -t"

alias -g tarc="sudo tar -czpvf"
alias -g tarx="sudo tar --strip-components=4 -xzpvf"
alias -g tarxfat="sudo tar --strip-components=4 --no-same-owner -xzpvf"

alias -g ramdisko="find . | cpio -o -H newc | gzip > ../initramfs_.cpio.gz"
alias -g ramdiski="gunzip -c ../initramfs.cpio.gz | cpio -i"
alias -g mkimg="mkbootimg --kernel zImage --ramdisk initramfs_.cpio.gz --base 0x40000000 --cmdline 'console=ttyS0,115200 rw init=/init loglevel=4 vmalloc=384M ion_reserve=128M' -o new_block.img"

alias -g mount_arch_desktop="sudo mount -t nfs 192.168.1.42:/ /_/nfs/arch_desktop"

alias -g chmod_dir="find /path/to/dir -type d -print0 | xargs -0 chmod 755"
alias -g chmod_files="find /path/to/dir -type f -print0 | xargs -0 chmod 644"

alias -g video_from_jpg="ffmpeg -f image2 -start_number 1982 -r 7 -i DSC0%d.JPG -y -r 25 -vcodec mpeg4 test.mp4"

alias -g valgringo="valgrind -v --leak-check=full --show-reachable=yes"

alias -g lj="journalctl -b --user | tail -20"
alias -g lm="find . -cmin -1"

alias -g create_efistub="sudo efibootmgr -d /dev/sda -p 1 -c -L \"arch_efi_test\" -l /EFI/arch/vmlinuz-linux -u \"root=/dev/sda3 rw rootflags=noatime,discard elevator=nop initrd=/EFI/arch/initramfs-linux.img\""

alias -g plz='eval "sudo $(fc -ln -1)"'
alias -g pingg="ping 8.8.8.8"

################################################################################
################################################################################


..(){
	declare -i count
	
	if [[ $1 -ge 1 ]]; then
		count=$1
	else
		count=1
	fi
	
	for ((i = 0; i < $count; i++)); do
		cd ..
	done
	
}


check_network(){
	echo -n "LAN: "
	print_ping_state "192.168.1.254"
	
	echo -n "WAN: "
	print_ping_state "8.8.8.8"
	
	echo -n "DNS: "
	print_ping_state "www.google.com"
}


print_ping_state(){
	if (ping -W 2 -c 1 $1 &> /dev/null); then
		echo "OK"
	else
		echo "NOPE"
	fi
}


set_dark_theme(){
    gsettings set org.gnome.shell.extensions.user-theme name Paper2
    gsettings set org.gnome.desktop.interface gtk-theme Arc-Dark
    gsettings set org.gnome.desktop.interface icon-theme Numix-Circle
    gsettings set org.gnome.gedit.preferences.editor scheme 'solarized-dark'
}


set_light_theme(){
    gsettings set org.gnome.shell.extensions.user-theme name Paper2
    gsettings set org.gnome.desktop.interface gtk-theme Paper2
    gsettings set org.gnome.desktop.interface icon-theme Numix-Circle-Light
    gsettings set org.gnome.gedit.preferences.editor scheme 'solarized-light'
}


xboxdrv_wiiupro(){
	sudo xboxdrv -c /_/etc/games/wiiupro.xboxdrv --mimic-xpad-wireless
}


xboxdrv_wiiupro2(){
	sudo xboxdrv -c /_/etc/games/wiiupro2.xboxdrv --type xbox360-wireless --led 2 --mimic-xpad-wireless
}


machine_suspend(){
	declare -i timer
	timer=0
	if [[ $1 -ge 1 ]]; then
		timer=$1
	else
		timer=4444
	fi
	echo "Sleeping in $timer seconds"
	sleep $timer
	systemctl suspend
	echo '\tGoing to sleep'
	echo '\tBye'
	sleep 2
}


machine_hibernate(){
	echo '\n\tWinter is coming...'
	sleep 1
	echo '\t...Going into hibernation mode'
	sleep 2
	echo '\nIt was a joke, the hard drive has crashed.'
	echo 'Now your computer is going to explode in'
	sleep 3
	for ((i = 3; i > 0; i--)); do
		echo '\t'$i;
		sleep 1
	done;
	systemctl hibernate
}


machine_poweroff(){
	systemctl poweroff
	sleep 1
	echo '\n\tPowering off in'
	sleep 1
	for ((i = 3; i > 0; i--)); do
		echo '\t'$i;
		sleep 1
	done;
}


assign_proxy(){
	PROXY_ENV=(http_proxy ftp_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY)
	for envar in $PROXY_ENV; do
		echo $envar=$1
		export $envar=$1
	done
	PROXY_ENV=(no_proxy NO_PROXY)
	for envar in $PROXY_ENV; do
		echo $envar=$2
		export $envar=$2
	done
}


proxy_off(){
	gsettings set org.gnome.system.proxy mode none
	assign_proxy ""
}


proxy_on(){

#	user=keiwop
#	read -p "Password: " -s pass &&  echo -e " "
#	proxy_value="http://$user:$pass@ProxyServerAddress:Port"

	host="192.168.43.1"
	port="4242"
	ignore_hosts="['localhost', '127.0.0.0/8', '::1']"

	if [[ -n $1 ]]; then
		if [[ $1 = "fac" ]]; then
			host="http://proxy-web.univ-fcomte.fr"
			port="3128"
		elif [[ $1 = "android" ]]; then
			host="192.168.43.1"
			port="4242"
		elif [[ $1 = "test" ]]; then
			host="192.168.43.1"
			port="4243"
		elif [[ $1 = "wan_android" ]]; then
			host="92.90.21.51"
			port="4242"
		else
			host=$1
			port=$2
		fi
	fi
	
#	Global gnome proxy config
	gsettings set org.gnome.system.proxy mode manual
	gsettings set org.gnome.system.proxy ignore-hosts $ignore_hosts
	gsettings set org.gnome.system.proxy.ftp host $host
	gsettings set org.gnome.system.proxy.ftp port $port
	gsettings set org.gnome.system.proxy.http host $host
	gsettings set org.gnome.system.proxy.http port $port
	gsettings set org.gnome.system.proxy.https host $host
	gsettings set org.gnome.system.proxy.https port $port
	gsettings set org.gnome.system.proxy.socks host $host
	gsettings set org.gnome.system.proxy.socks port $port
	
#	Shell proxy config
	proxy_value="${host}:${port}"
	no_proxy_value="localhost,127.0.0.1,LocalAddress,LocalDomain.com"
	assign_proxy $proxy_value $no_proxy_value
}


hexof(){
    emulate -L zsh
    if [[ -n "$1" ]]; then
        printf "%x\n" $1
    else
        print 'Usage: hex <number-to-convert>'
        return 1
    fi
}


set_a_eabi(){
	 export PATH="$cpath_android:$cpath_a_eabi:$PATH"
	 export LD_LIBRARY_PATH="$clib_a_eabi:$LD_LIBRARY_PATH"
}


################################################################################
################################################################################
#	U+	Ctrl + Shift + U
#	‾	U+203E
#	¯	U+00AF

WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' # the default
WORDCHARS=.
WORDCHARS='*?_[]~=&;!#$%^(){}'
WORDCHARS='${WORDCHARS:s@/@}'

setopt histallowclobber
setopt nocheckjobs
setopt printexitvalue
setopt interactivecomments

export MANWIDTH=${MANWIDTH:-80}
export EDITOR="vi"
tabs 4

stty erase "^?"

# 10 second wait after a rm * (Best thing ever !)
setopt RM_STAR_WAIT

# use magic (this is default, but it can't hurt!)
setopt ZLE
setopt NO_HUP
#setopt VI

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# Case insensitive globbing
setopt NO_CASE_GLOB

# Be Reasonable!
setopt NUMERIC_GLOB_SORT

# I don't know why I never set this before.
setopt EXTENDED_GLOB

# hows about arrays be awesome?  (that is, frew${cool}frew has frew surrounding all the variables, not just first and last
setopt RC_EXPAND_PARAM

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt NOTIFY
setopt NOHUP
setopt MAILWARN

HISTFILE=$HOME/.zsh_history
HISTSIZE=4194304
SAVEHIST=4194304

################################################################################
################################################################################

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

#Ctrl + Left
bindkey ';5D' 	emacs-backward-word
#Ctrl + Right
bindkey ';5C' 	emacs-forward-word
#Ctrl + Shift + Left
bindkey	';6D'	backward-delete-word
#Ctrl + Shift + Right
bindkey	';6C'	delete-word

#Alt + Up
bindkey	';3A'	beginning-of-line
#Alt + Down
bindkey	';3B'	beginning-of-line
#Alt + Right
bindkey	';3C'	beginning-of-line
#Alt + Left
bindkey	';3D'	beginning-of-line
#F11
bindkey '^[[23~' beginning-of-line

prompt_padding_size=$((prompt_padding_size - 1))

