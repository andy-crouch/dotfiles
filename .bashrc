###############################################################################
# .bashrc file.
# -------------
#
# Date Last Modified : 28/08/2012
#
# My regular .bashrc containing various functions, alias's and 
# colour settings.
#
# change ~/.bashrc to
#
# if [ -f /etc/bashrc ]; then
#        . /etc/bashrc   # --> Read /etc/bashrc, if present.
#	fi
#
###############################################################################

# EXPORTS
###############################################################################

# COLOUR & FONT DEFINITIONS 
###############################################################################

# Style definitions ...
BOLD='\E[1m'
NOBOLD='\E[0m'

# Colour defintions ...
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m'


# SETTINGS
###############################################################################

# Autocompletion checking ...
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Add ~/Dropbox/ShellScripts to path ...
if [ -d /Dropbox/ShellScripts ]; then
	PATH=$PATH:/Dropbox/ShellScripts
	export PATH
fi

# set svn editor to be vim
export SVN_EDITOR=vim

# source the rvm config file ...
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Check for an interactive session ...
[ -z "$PS1" ] && return

# Set Vi keybindings ...
set -o vi

# Prompt definition (username@host absolute path $) ...
PS1='\[\e[0;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[0;37m\]'

# Welcome message ...
PS2='>'
welcome_msg="${WHITE}Welcome ${RED}${BOLD}$USER${NOBOLD}${WHITE} :: `date`"

# modified to allow the correct command to get the ip address to run based on if we 
# are in Cygwin (windows) or not.  Default command is ifconfig ...
[ $HOSTNAME == 'kermit' ] && ip_op=`ipconfig  | grep 'IPv4 Add'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'` || ip_op=`ifconfig  | grep 'inet '| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $2}'`
ip_add=$ip_op

echo -e $welcome_msg
for ((i=34;i<${#welcome_msg};i++));
        do
                echo -n "-"
        done
echo -e "\n"
echo -e "${WHITE}Host    :: ${BLUE}${BOLD}$HOSTNAME${NOBOLD}"
echo -e "${WHITE}Kernel  :: ${BLUE}${BOLD}`uname -smr`${NOBOLD}"
echo -e "${WHITE}IP      :: ${BLUE}${BOLD}$ip_add${NOBOLD}${NC}"
echo -e "\n"

# ALIAS's
###############################################################################
# Read the ~/.bash_aliases file on the machine to load local aliases ...
if [ -f ~/.bash_aliases ]; then
 . ~/.bash_aliases
fi

alias ll="ls -lFh --color=auto"
alias lla="ls -Al | less"

# FUNCTION DEFINITIONS
###############################################################################
# Inflate the file passed in $1 ...
function Expand() 
{
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)		tar xjf $1                ;;
			*.tar.gz)       tar xzf $1                ;;
			*.bz2)          bunzip2 $1                ;;
			*.rar)          rar x $1                ;;
			*.gz)           gunzip $1                ;;
			*.tar)          tar xf $1                ;;
			*.tbz2)         tar xjf $1                ;;
			*.tgz)          tar xzf $1                ;;
			*.zip)          unzip $1                ;;
			*.Z)            uncompress $1        ;;
			*)              echo "'$1' cannot be extracted via Expand()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# Get IP related information ...

# Show systemm network and various use related pieces of information ...
function ShowSystemInfo()   
{
	IPAdd=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`
	EXTAdd=`wget -O - whatismyip.com 2> /dev/null | grep "Your IP Address Is" | sed -e 's/^.*Is//' -e 's/<.*$//'`

    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free

    echo -e "\n${RED}Local IP Address :$NC" ; echo ${IPAdd:-"Not connected"}
    echo -e "\n${RED}ISP Address :$NC" ; echo ${ExtAdd:-"Not connected"}
    echo -e "\n${RED}Open connections :$NC "; netstat -pan --inet;
    echo
}

function open()
{
	UNAME=`uname`
	OSLINUX="Linux"
	OSCYGWIN="CYGWIN_NT-6.1-WOW64"
	
	if [ "$UNAME" = "$OSLINUX" ]; then
		if [ "$1" = "" ]; then
			echo "open Failed, No file specified to open."
		else
			xdg-open "$1"
		fi
	elif [ "$UNAME" = "$OSCYGWIN" ]; then
		if [ "$1" = "" ]; then
			NATIVE_PATH="."
		else
			NATIVE_PATH="$1"
		fi

		WIN_PATH=`cygpath -w -a "${NATIVE_PATH}"`
		cmd /C start "" "$WIN_PATH"
	fi
}

