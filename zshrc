#!	/usr/bin/zsh
################################################################################
################################################################################
#keiwop="Maxime Martin"
#licenses=(BSDv3+ WTFPLv2+)



################################################################################
#Prompt
################################################################################

autoload -Uz promptinit
promptinit
prompt suse
autoload -U colors && colors
PROMPT="%{$fg_bold[green]%}%#%{$fg_bold[cyan]%}%1~%{$fg_bold[magenta]%}❯%{$reset_color%}%"
RPROMPT="%{$fg_bold[green]%}%~ %{$fg[magenta]%}- %{$fg_bold[cyan]%}%n%{$fg_bold[magenta]%}:%{$fg[cyan]%}%m%{$fg[magenta]%}:%{$fg[blue]%}%l %{$fg[magenta]%}- %{$fg_bold[white]%}%T %{$fg[magenta]%}- %{$fg_bold[yellow]%}[Ø]%{$reset_color%}"



################################################################################
#Options
#http://zsh.sourceforge.net/Doc/Release/Options.html
################################################################################

#Use case-insensitive globbing
unsetopt CASE_GLOB
#Let the completion expand the alias to find the arguments of the command
unsetopt COMPLETE_ALIASES
#Complete the word where the cursor is positionned
setopt COMPLETE_IN_WORD
#Use the char '#', '~' and '^' for pattern search (unquoted '~' produces home expansion)
setopt EXTENDED_GLOB
#Display the completions in a regular grid
setopt LIST_TYPES
#Always show the completion menu with ambiguous completions (instead of typing once more on tab)
setopt MENU_COMPLETE
#Should be turned off when SHARE_HISTORY is in use
unsetopt APPEND_HISTORY
#Append the commands to the history like APPEND_HISTORY with a timestamp and import new commands
setopt SHARE_HISTORY
#Report the status of background jobs immediatly
setopt NOTIFY
#Print a warning when the mail file has been accessed
setopt MAIL_WARNING
#Exit a shell without any care for the suspended or background jobs
setopt NO_CHECK_JOBS
setopt NOHUP
#With pattern search, sort the filenames numerically
setopt NUMERIC_GLOB_SORT
#Print the exit value of a program if it's non-zero
setopt PRINT_EXIT_VALUE
#Expand "foo${xx}bar" with xx set to (a b c) to "fooabar foobbar foocbar"
setopt RC_EXPAND_PARAM 	#Doesn't seem to work
#Enable the line editor
setopt ZLE



################################################################################
#Completion
#http://zsh.sourceforge.net/Doc/Release/Completion-System.html
################################################################################

autoload -Uz compinit zsh/complist
compinit
#Show the menu when at least 1 choice is proposed
zstyle ':completion:*' menu select=1
#Force rehash for completing newly installed programs
zstyle ':completion:*' rehash true
#Don't show the directories of $cdpath in the completion of cd
#zstyle ':completion:*:cd:*' tag-order local-directories path-directories
#Order of types of completion to try, expand the aliases first
zstyle ':completion:*' completer _expand_alias _complete _correct _approximate _expand
#Use the same colours as ls
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#Match for case-insensitive completion
zstyle ':completion:*' matcher-list '' '+m:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
#Set the verbose mode
zstyle ':completion:*' verbose yes
#Use the default list separator
zstyle ':completion:*' list-separator '--'
#Use completion on the .. dir
zstyle ':completion:*' special-dirs '..'
#Make the completion groups separated
zstyle ':completion:*' group-name ''
#Set the order of the completion groups proposed (type "cd<TAB>" to see)
zstyle ':completion:*' group-order aliases functions builtins commands parameters

#Colorize the list of proposed completions
zstyle ':completion:*:aliases'  list-colors '=*=01;35'
zstyle ':completion:*:functions'  list-colors '=*=01;34'
zstyle ':completion:*:builtins'  list-colors '=*=01;31'
zstyle ':completion:*:commands'  list-colors '=*=01;32'
zstyle ':completion:*:parameters'  list-colors '=*=01;33'

#Change the format and color of some messages
zstyle ':completion:*:descriptions' format $'\e[01;36m%d:\e[00m' 	#(type "cd<TAB>")
zstyle ':completion:*:warnings' format $'\e[01;31mNo matches for:\e[00m \e[01;33m%d\e[00m' #(type "abcdefgh<TAB>")
zstyle ':completion:*:messages' format $'\e[01;32m%d\e[00m' 		#untested
zstyle ':completion:*' select-prompt '%SSelection at %p%s' 			#(type "ls -<TAB>" or "man <TAB>")
zstyle ':completion:*' auto-description 'specify: %d' 				#untested

#Change the color of options for commands (type "ls -<TAB>" or "date -<TAB>")
zstyle ':completion:*:options:*' list-colors '=^(-- *)=01;31' '=(#b)(--) *=01;35=01;35'
#Change the color of previous dir for cd (type "cd -<TAB>")
zstyle ':completion:*:*:cd:*' list-colors '=(#b)([0-9]#) (--) *=01;35=01;31=01;35'
#Change the list colors for tar (type "tar -<TAB>")
zstyle ':completion:*:*:tar:*' list-colors '=(#b)([a-zA-Z]#) #(--) *=01;35=01;31=01;35'
#Make kill a bit nicer (type "kill <TAB>")
zstyle ':completion:*:*:kill:*' list-colors '=(#b) #([0-9]#)*( *[a-zA-Z0-9_-\(\)<>])*=01;32=01;31=01;35'
#Show the man sections as separated
zstyle ':completion:*:manuals' separate-sections true



################################################################################
#Variables
################################################################################

export EDITOR=vi
export MANWIDTH=${MANWIDTH:-80}
#Only show the last 12 visited dirs (type "cd -<TAB>")
export DIRSTACKSIZE=12
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=16777216
export SAVEHIST=16777216
#Default chars used to define a word.
export WORDCHARS="*?_-.[]~=/&;!#$%^(){}<>"
#Variables to calculate the time a command took to execute (see the hooks functions)
typeset -ig _preexec=$(date '+%s%N' | cut -b1-13)
typeset -ig _postexec=$(date '+%s%N' | cut -b1-13)



################################################################################
#Path
################################################################################

#All the directories in /_ are accessible with cd from anywhere
cdpath=(/_)
#Path for good stuff
path=($path /_/bin /_/src/scripts /_/src/python /_/src/kbd/bin)
#Path for things I don't like to use
path=($path \
	/usr/share/java/javacc-5.0/bin \
	/_/opt \
	/_/opt/ti/mspgcc/bin \
	/_/opt/sicstus4.3.2/bin \
	/_/opt/netlogo-5.3.1-64)

ld_library_path=($ld_library_path \
	/_/lib \
	/_/src/kbd/bin/lib \
	/_/opt/sicstus-4.3.2/lib)
CLASSPATH=($CLASSPATH \
	/usr/share/java/junit.jar \
	/usr/share/java/javacc-5.0/bin/lib/javacc.jar \
	/_/opt/sicstus4.3.2/lib/sicstus-4.3.2/bin/*.jar \
	/_/opt/netlogo-5.3.1-64/runtime/lib/*.jar)

#Remove the duplicates from the path
typeset -U path



################################################################################
#Aliases
################################################################################
alias ll="ls -lhpF --color=auto"
#ll with the recursive option
alias lll="ll -CR"
#ll showing the hidden files
alias la="ll -a"
#Show the files (and dirs) in all the subdirectories modified in the last 5mn
alias lm="ll **/*(.mm-5)"
alias lama="ll **/*(D.mm-5)" 	#Same but including all the hidden files
#Show the last 16 files modified in all the subdirectories
alias lo="ll **/*(.om[1,16])"
alias llo="ll **/*(D.om[1,16])" 	#Same but including all the hidden files
#Show the files bigger than 42MB in all the subdirectories
alias lk="ll **/*(.Lm+42)"
alias llk="ll **/*(D.Lm+42)" 	#Same but including all the hidden files
#Show the last 20 entries of the journal log
alias lj="journalctl -b --user | tail -20"
#Show the ports used on the machine
alias lp="sudo netstat -plnt"

#I'm lazy
alias cdf='cd /_/src/fac/M1'

#Use a global alias when you want to use your alias in a command
#eg: "cd ..."
alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."

alias mkd="mkdir_cd"
alias mountt="mount | column -t"

#Rsync over the network
alias rs="rsync -av --progress --inplace --rsh='ssh -p42'"
#Copy a filesystem
alias rs_bkp="rsync -avxS --progress"

#See the functions tar_compress and tar_decompress
alias tarc="tar_compress"
alias tarx="tar_decompress"
alias tarxfat="sudo tar --strip-components=4 --no-same-owner -xzpvf"

#Make the boot.img for an Android device
alias ramdisko="find . | cpio -o -H newc | gzip > ../initramfs_.cpio.gz"
alias ramdiski="gunzip -c ../initramfs.cpio.gz | cpio -i"
alias mkimg="mkbootimg --kernel zImage --ramdisk initramfs_.cpio.gz --base 0x40000000 --cmdline 'console=ttyS0,115200 rw init=/init loglevel=4 vmalloc=384M ion_reserve=128M' -o new_block.img"

#TODO Recode chmod and chown as functions
alias chmod_dir="find /path/to/dir -type d -print0 | xargs -0 chmod 755"
alias chmod_files="find /path/to/dir -type f -print0 | xargs -0 chmod 644"

#There is a function now
#alias create_efistub="sudo efibootmgr -d /dev/sda -p 1 -c -L 'arch_efi' -l /arch/vmlinuz-linux -u 'root=/dev/sda2 rw rootflags=noatime,discard elevator=noop initrd=/arch/initramfs-linux.img'"

#Forgot to add sudo at the beginning of your command? Ask nicely this time
alias plz='eval "sudo $(fc -ln -1)"'

#Watch'em all!
alias watch_disks="watch -n 1 'sudo hdparm -C /dev/sd?'"
alias watch_disks_log="watch -n 1 'tail -n 16 /var/log/disks_states.log'"
alias watch_system_log="watch -n 1 'tail -n 16 /var/log/arch_desktop.log'"
alias watch_nvidia="watch -n 1 'sudo nvidia-smi'"
alias watch_sensors="watch -n 1 'sudo sensors'"
alias watch_dmesg="watch -n 1 'dmesg | tail -n 16'"

#Configure your serial bluetooth adapter
alias bt_set_name="sudo echo 'AT+NAMEkeiwop' >> /dev/ttyUSB0"
alias bt_set_pin="sudo echo 'AT+PIN0000' >> /dev/ttyUSB0"
alias bt_set_baud="sudo echo 'AT+BAUD4' >> /dev/ttyUSB0"

#Print the top10 of the most used commands
alias top10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
#Program a clone of arduino pro micro (A Makefile is now available in your local newspaper)
alias prog_32u4='avrdude -v -v -v -v -D -P/dev/ttyACM0 -cavr109 -b57600 -patmega32u4 -Uflash:w:firmware:i'
#Make a gif, badly
alias video_from_jpg="ffmpeg -f image2 -start_number 1982 -r 7 -i DSC0%d.JPG -y -r 25 -vcodec mpeg4 test.mp4"
#Just in case autotfs doesn't work
alias mount_arch_desktop="sudo mount -t nfs 192.168.1.42:/ /_/nfs/arch_desktop"
#¡Hola!
alias valgringo="valgrind -v --leak-check=full --show-reachable=yes"

#Network stuff
alias pingg="ping 8.8.8.8"
alias ssh_router="ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 ${router_user}@${router_addr}"
alias fac_mtu="sudo ip link set wlp3s0 mtu 1000; sudo ip link set tap0 mtu 1000"
alias get_file="wget --user=${seedbox_user} --password=${seedbox_passwd} --no-check-certificate -r --reject='index.html*' -nH -np --cut-dirs=2"

#Git stuff
alias pushm="git push origin HEAD:master"
alias pullm="git pull origin master"

#Replace the js used by the the current instance of Gnome
alias -g use_custom_gjs="GNOME_SHELL_JS=/_/dev/gnome/gnome_shell gnome-shell --replace"

#Touch recursively the files of the current dir
alias -g touch_all="find . -exec touch {} \;"


################################################################################
#Functions
################################################################################

#Print the duration given a number of seconds + milliseconds
#Example: 63123 returns 1:03.123
print_duration(){
	duration=$1
	millis=${duration[-3, -1]}
	
	if [[ $duration -ge 1000 ]]; then
		duration=${duration[1, -4]}
		hours=$(( $duration / 3600 ))
		duration=$(( $duration % 3600 ))
		minutes=$(( $duration / 60 ))
		duration=$(( $duration % 60 ))
		seconds=$duration
	else
		hours=0
		minutes=0
		seconds=0
	fi
	
	result=""
	
	if [[ $hours -ge 1 ]]; then
		minutes=${(l:2::0:)minutes}
		seconds=${(l:2::0:)seconds}
		result="$hours:$minutes:"
	elif [[ $minutes -ge 1 ]]; then
		seconds=${(l:2::0:)seconds}
		result="$minutes:"
	fi

	millis=${(l:3::0:)millis}

	result="${result}${seconds}.${millis}"
	echo -n "$result"
}


#It isn't possible to be more self-explanatory
mkdir_cd(){
	mkdir -p $1
	cd $1
}


#Go to the parent dir
#If there is an arg, go to $1 levels above the current directory
..(){
	typeset -i count=1
	
	if [[ $1 -gt 1 ]]; then
		count=$1
	fi
	
	for ((i = 0; i < $count; ++i)); do
		cd ..
	done
}


#Check if the network is functionning
#Test the LAN by pinging the router, then the WAN by pinging a DNS server of Google
#Lastly, ping www.google.com to see if I can get through the DNS
check_network(){
	echo -n "LAN: "
	print_ping_state "192.168.1.254"
	
	echo -n "WAN: "
	print_ping_state "8.8.8.8"
	
	echo -n "DNS: "
	print_ping_state "www.google.com"
}

#Send a single ping and wait 2 seconds for the response
#If it came back, good for you
print_ping_state(){
	if (ping -W 2 -c 1 $1 &> /dev/null); then
		echo "OK"
	else
		echo "NOPE"
	fi
}


#To redo when gnome will be capable to switch the night mode at runtime...
set_dark_theme(){
	gsettings set org.gnome.shell.extensions.user-theme name Flat-Plat
	gsettings set org.gnome.desktop.interface gtk-theme Arc-Dark
	gsettings set org.gnome.desktop.interface icon-theme Numix-Circle
	gsettings set org.gnome.gedit.preferences.editor scheme 'solarized-dark'
}


set_light_theme(){
	gsettings set org.gnome.shell.extensions.user-theme name Flat-Plat
	gsettings set org.gnome.desktop.interface gtk-theme Flat-Plat
	gsettings set org.gnome.desktop.interface icon-theme Numix-Circle
	gsettings set org.gnome.gedit.preferences.editor scheme 'solarized-light'
}


#Emulate a wiiu pro controller as a xbox 360 controller
xboxdrv_wiiupro(){
	sudo xboxdrv -c /_/fun/games/wiiupro.xboxdrv --type xbox360-wireless --led 2 --mimic-xpad-wireless
}


#Put the machine in suspend mode at the end of the timer
#The timer can be the first argument in seconds
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


#Put the machine in hibernation mode
#I don't know why I coded this in the first place, I never use it
#I don't even know why I'm commenting it instead of deleting it
machine_hibernate(){
	echo '\n\tWinter is coming...'
	sleep 1
	echo '\t...Going into hibernation mode'
	sleep 2
	echo '\nIt was a joke, the hard drive has crashed.'
	echo 'Now your computer is going to explode in'
	sleep 3
	for ((i = 3; i > 0; --i)); do
		echo "\t$i"
		sleep 1
	done
	systemctl hibernate
}


#Turn off the machine and then print a message. Brilliant!
#(Actually, the machine takes a bit off time to react to the command, so it works)
machine_poweroff(){
	systemctl poweroff
	sleep 1
	echo '\n\tPowering off in: '
	sleep 1
	for ((i = 3; i > 0; --i)); do
		echo "\t$i"
		sleep 1
	done
}


#For all the variable names in the array PROXY_ENV, assign it the proxy given in parameter
#This function is used in proxy_on and proxy_off
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


#Turn the proxy off and go back to normal
proxy_off(){
	gsettings set org.gnome.system.proxy mode none
	assign_proxy ""
}


#If I type "proxy_on fac", I can browse dank memes at high speed during class. Yay!
#Seriously, this function try to set the proxy by any means(also in gnome via gsettings)
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
		elif [[ $1 = "wan_android" ]]; then
			host="12.34.56.78"
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


#Print the hex value from a int passed as parameter
hexof(){
	if [[ -n $1 ]]; then
		printf "%x\n" $1
	fi
}

#The aircrack serie of functions begins
#TODO I'll put them all in a script somewhere, someday, somehow
set_monitor_mode(){
	sudo systemctl stop NetworkManager.service
	sudo systemctl stop wpa_supplicant.service 
	sudo ip link set wlp3s0 down
	sudo iwconfig wlp3s0 mode Monitor
	sudo airmon-ng start wlp3s0 9
}


unset_monitor_mode(){
	sudo systemctl restart wpa_supplicant.service 
	sudo systemctl restart NetworkManager.service
}


alias scan_networks="sudo airodump-ng wlp3s0"
#alias wpa_handshake="sudo airodump-ng wlp3s0 -c 11 -w psk --bssid 02:1A:11:FB:0C:D6"
#alias wpa_aireplay="sudo aireplay-ng wlp3s0 -0 42 -a 02:1A:11:FB:0C:D6 -c DC:85:DE:07:BB:48"
#alias wpa_aircrack="sudo aircrack-ng -w dict -b 02:1A:11:FB:0C:D6 psk*.cap"

wpa_scan_handshake(){
	if [[ $1 -ge 1 ]]; then
		export wpa_channel=$1
	fi
	
	if [[ -n $2 ]]; then
		export wpa_ssid=$2
	fi
	
	sudo airodump-ng wlp3s0 -c $wpa_channel -w psk --bssid $wpa_ssid
}

wpa_disconnect_client(){
	if [[ -n $1 ]]; then
		export wpa_client_ssid=$1
	fi
	
	sudo aireplay-ng wlp3s0 -0 42 -a $wpa_ssid -c $wpa_client_ssid
	cat >> wpa_log <<-EOF
	ssid: $wpa_ssid
	client: $wpa_client_ssid
	EOF
}

wpa_crack_passwd(){
	if [[ -n $1 ]]; then
		export wpa_dict_list=$1
	fi
	
	sudo aircrack-ng -w $wpa_dict_list -b $wpa_ssid psk*.cap
}


#Generate a png for a graph described in a dot file
generate_dot(){
	for arg in $@; do
		echo $arg
		dot -Tpng $arg -o $arg.png
	done
}

generate_neato(){
	neato -Tpng $1 -o $1.png
}

generate_twopi(){
	twopi -Tpng $1 -o $1.png
}

generate_fdp(){
	fdp -Tpng $1 -o $1.png
}


#HiDPI support of the poor
#It's ugly, but it kinda works
config_desktop_screens(){
	xrandr --output HDMI-0 --scale 0.7x0.7
	xrandr --output DVI-I-1 --scale 1x1
}


#Create a script to debug problems at shutdown
#Basically write dmesg to the log at the last moment possible
create_debug_script(){
	_debug_script="/usr/lib/systemd/system-shutdown/debug.sh"
	
	if ! [[ -e ${_debug_script} ]]; then
		echo "Creating debug script ${_debug_script}"
		sudo touch ${_debug_script}
		sudo chmod 777 ${_debug_script}
		cat >> ${_debug_script} <<-EOF
		#! /bin/sh
		mount -o remount,rw /
		dmesg > /var/log/last_shutdown.log
		mount -o remount,ro /
		EOF
	fi
	
	if [[ $1 == "force" ]]; then
		sudo mv ${_debug_script} "${_debug_script}.bkp"
		create_debug_script
	fi
}


#Create a new efistub entry to boot directly the kernel from the efi
#GRUB is now ancient history
create_efistub(){
	_efi_label="arch_efi"
	_efi_disk="/dev/sda"
	_efi_root="/dev/sda2"
	_efi_part="1"
	_efi_kernel="/arch/vmlinuz-linux"
	_efi_initrd="/arch/initramfs-linux.img"
	_efi_rootflags="noatime,discard"
	_efi_args="root=${_efi_root} rw rootflags=${_efi_rootflags} elevator=noop initrd=${_efi_initrd}"

	if [[ -n $1 ]]; then
		if [[ $1 == "debug" ]]; then
			_efi_args="${_efi_args} systemd.log_level=debug systemd.log_target=kmsg log_buf_len=4M enforcing=0"
			if [[ $2 == "-f" ]]; then
				create_debug_script force
			else
				create_debug_script
			fi
		else
			_efi_label="$1"
		fi
	fi

	echo "efibootmgr -d ${_efi_disk} -p ${_efi_part} -c -L ${_efi_label} -l ${_efi_kernel} -u ${_efi_args}"
	sudo efibootmgr -d ${_efi_disk} -p ${_efi_part} -c -L ${_efi_label} -l ${_efi_kernel} -u ${_efi_args}
}


#Encode a file to the h264 or h265 format
#Default on h265 at 2000Kb/s
encode_file(){
	if [[ -f $1 ]]; then
		codec="nvenc_hevc"
		bitrate=2000
		
		if [[ $2 -gt 0 ]]; then
			bitrate=$2
			if [[ $3 == "h264" ]]; then
				codec="nvenc"
			fi			
		elif [[ $2 == "h264" ]]; then
			codec="nvenc"
			bitrate=4000
		fi

		out_file="${1%.*}.${codec}.mkv"
		
		echo "Encoding file: $1"
		echo "Bitrate: $bitrate"
		echo "Output file: $out_file"
		
		ffmpeg -i $1 -c:a copy -c:s copy -c:v ${codec} -b:v ${bitrate}k $out_file			
	fi
}


#Compress the files passed as args in a .tar.gz
tar_compress(){
#	--create --gzip --same-permissions --verbose --file
	tar_flags="-czpvf"
	dir_name=$(basename $(pwd))

	if [[ -d $1 ]] && [[ -z $2 ]]; then
		gz_name=$1
		input_files=$1
	else
		gz_name=$dir_name
		input_files=($@)
	fi
	
	gz_file=$gz_name.tar.gz
	if [[ -e $gz_file ]]; then
		gz_file=${gz_name}_$(date +"%Y%m%d_%H%M%S").tar.gz
	fi
	
	echo "Compressing files:"
	tar $tar_flags $gz_file $input_files
	echo "\nOutput file: ${gz_file}"
}

#Decompress the archives passed as args in separate dirs
tar_decompress(){
	tar_flags="-xzpvf"
	
	for gz_file in $@; do
		gz_name=${$(basename $gz_file)%%.*}
		
		gz_dir=$gz_name
		if [[ -e $gz_dir ]]; then
			gz_dir=${gz_name}_$(date +"%Y%m%d_%H%M%S")
		fi
		mkdir -p $gz_dir
		
		echo "\nUncompressing archive: ${gz_file}"
		tar $tar_flags $gz_file -C $gz_dir
		echo "Output dir: ${gz_dir}"
	done
}


#XXX Warning, use at your own risk
#If I write the same file over and over (a builroot boot img for example), at a 
#certain point the sdcard will just stop writing new data
#So I write random data to the sdcard before writing the file passed in argument
ddd(){
	if [[ -e $2 ]] && [[ -b $1 ]]; then
		sudo dd if=/dev/urandom of=$1 count=16384
		sync
		sudo dd if=$2 of=$1 bs=4K
		sync
	fi
}



################################################################################
#Hooks
################################################################################

#_preexec stores the time before a command is executed
preexec(){
	_preexec=$(date '+%s%N' | cut -b1-13)
}

#_postexec stores the time after a command is executed
#The two are used to calculate the duration of a command and print it in the RPROMPT
precmd(){ 
	_postexec=$(date '+%s%N' | cut -b1-13)
	_exec_time="$(( $_postexec - $_preexec ))"
	rprompt_time=$(print_duration $_exec_time)
	
	RPROMPT="%{$fg_bold[green]%}%~ %{$fg[magenta]%}- %{$fg_bold[cyan]%}%n%{$fg_bold[magenta]%}:%{$fg[cyan]%}%m%{$fg[magenta]%}:%{$fg[blue]%}%l %{$fg[magenta]%}- %{$fg_bold[white]%}%T %{$fg[magenta]%}- %{$fg_bold[yellow]%}[$rprompt_time]%{$reset_color%}"
}



################################################################################
#Keybindings
################################################################################

#Setup keys which might not be default
#[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
#[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char

#Search the history from the line up to the cursor position when using Up or Down key
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

#You can find the keys to use with the command "showkey -a"
#Applying default keys of some laptops
bindkey "^[[H" beginning-of-line 							#Home (Laptop)
bindkey "^[[F" end-of-line 									#End (Laptop)
bindkey "^[[5~" beginning-of-buffer-or-history 				#PageUp (Laptop)
bindkey "^[[6~" end-of-buffer-or-history 					#PageDown (Laptop)

#Move the cursor to the start of the previous word
bindkey "^[[1;5D" vi-backward-blank-word 					#Ctrl + Left
#Move the cursor to the start of the next word
bindkey "^[[1;5C" vi-forward-blank-word 					#Ctrl + Right

#Deletes the word before the cursor
bindkey	"^[[1;6D" backward-delete-word 						#Ctrl + Shift + Left 
#Deletes the word after the cursor
bindkey	"^[[1;6C" delete-word 								#Ctrl + Shift + Right

#Swap the case of the char under the cursor
bindkey "^[[1;2A" vi-swap-case 								#Shift + Up
#Swap the case of a selection
#Press once then a vi movement to swap selected text or press twice and swap the line
bindkey "^[[1;2B" vi-oper-swap-case 						#Shift + Down
#Move the word under the cursor to the left
bindkey "^[[1;2D" transpose-words 							#Shift + Left
#Haven't found a way to move a word to the right, so it's useful for vi-oper-swap-case
bindkey "^[[1;2C" end-of-line 								#Shift + Right

#Undo the last action
bindkey "^[[1;2P" undo 										#Shift + F1
#Redo the last undone action
bindkey "^[[1;2Q" redo 										#Shift + F2
#You can also launch a command when using a shortcut
bindkey -s "^[[1;2R" "watch -n 1 'dmesg | tail -n 16'\n" 	#Shift + F3
bindkey -s "^[[15;2~" "yaourt -Syu\n" 						#Shift + F5
bindkey -s "^[[17;2~" "yaourt -Syua --noconfirm\n" 			#Shift + F6



################################################################################
#Misc
################################################################################

#Set the tab size to 4
tabs 4



################################################################################
#Plugins
################################################################################

#Enable fish-like syntax highlighting
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#Git version
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh






