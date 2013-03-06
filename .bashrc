# Check for an interactive session ...
[ -z "$PS1" ] && return

# Locate the .dotfiles directory.
DOTFILES=`find ~/ -maxdepth 1 -iname .dotfile* -type d`

# Get path to bash specific settings.
DF_BASH="${DOTFILES}/bash/"

# Source the files in .dotfiles/bash/.  (Note machine
# dependant content can be handled by creating files with
# _HOSTNAME suffix.  To completely override a file create
# a directory in bash/ named HOSTNAME and add any of the 
# standard bash/ based files with no suffix).
BASHFILES=`find ${DF_BASH} -maxdepth 1 -iname '.bash_*' -a ! -iname '*.bash_*_*'`
for file in $BASHFILES
do
	if [[ -d "${DF_BASH}/${HOSTNAME}" ]]; then
		echo "Processing host overide file => $MFILE ... "
	else
		if [[ -r "$file" ]]; then
			. "$file"
			MFILE="${file}_${HOSTNAME}"
			if [[ -e "$MFILE" ]]; then
				. "$MFILE"
				echo "Processing host file => $MFILE ... "
			fi
			unset MFILE
		else
			echo -e "Warning - Unable to source .bash_functions.\n\n"
		fi
	fi
done
unset file

# Enable bash completion.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# Set Vi keybindings ...
set -o vi

# +++++++++++++ OLD ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#if [ -f /etc/bash_completion ]; then
    #. /etc/bash_completion
#fi


# COLOUR & FONT DEFINITIONS 
###############################################################################

# Style definitions ...
#BOLD='\E[1m'
#NOBOLD='\E[0m'

## Colour defintions ...
#BLACK='\e[0;30m'
#BLUE='\e[0;34m'
#GREEN='\e[0;32m'
#CYAN='\e[0;36m'
#RED='\e[0;31m'
#PURPLE='\e[0;35m'
#BROWN='\e[0;33m'
#LIGHTGRAY='\e[0;37m'
#DARKGRAY='\e[1;30m'
#LIGHTBLUE='\e[1;34m'
#LIGHTGREEN='\e[1;32m'
#LIGHTCYAN='\e[1;36m'
#LIGHTRED='\e[1;31m'
#LIGHTPURPLE='\e[1;35m'
#YELLOW='\e[1;33m'
#WHITE='\e[1;37m'
#NC='\e[0m'


# SETTINGS
###############################################################################

# Autocompletion checking ...
#if [ -f /etc/bash_completion ]; then
    #. /etc/bash_completion
#fi

# Add ~/Dropbox/ShellScripts to path ...
if [ -d /Dropbox/ShellScripts ]; then
	PATH=$PATH:/Dropbox/ShellScripts
	export PATH
fi

# set svn editor to be vim
export SVN_EDITOR=vim

# source the rvm config file ...
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"



## Prompt definition (username@host absolute path $) ...
#PS1='\[\e[0;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[0;37m\]'

## Welcome message ...
#PS2='>'
#welcome_msg="${WHITE}Welcome ${RED}${BOLD}$USER${NOBOLD}${WHITE} :: `date`"

## modified to allow the correct command to get the ip address to run based on if we 
## are in Cygwin (windows) or not.  Default command is ifconfig ...
#[ $HOSTNAME == 'kermit' ] && ip_op=`ipconfig  | grep 'IPv4 Add'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'` || ip_op=`ifconfig  | grep 'inet '| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $2}'`
#ip_add=$ip_op

#echo -e $welcome_msg
#for ((i=34;i<${#welcome_msg};i++));
        #do
                #echo -n "-"
        #done
#echo -e "\n"
#echo -e "${WHITE}Host    :: ${BLUE}${BOLD}$HOSTNAME${NOBOLD}"
#echo -e "${WHITE}Kernel  :: ${BLUE}${BOLD}`uname -smr`${NOBOLD}"
#echo -e "${WHITE}IP      :: ${BLUE}${BOLD}$ip_add${NOBOLD}${NC}"
#echo -e "\n"

## ALIAS's
################################################################################
#if [ -f $DOTFILES/bash/.bash_aliases ]; then
	#. $DOTFILES/bash/.bash_aliases 
#else
	#echo -e "Warning - Unable to source .bash_aliases \n\n"
#fi

#ALIASE_FILES=$DOTFILES/bash/.bash_aliases_*
#MACHINE_ALIASES="${DOTFILES}/bash/.bash_aliases_${HOSTNAME}"
#for f in $ALIASE_FILES
#do
	#if [ "$f" = "$MACHINE_ALIASES" ]; then
		#. $MACHINE_ALIASES
	#fi
#done

## FUNCTION DEFINITIONS
################################################################################
#if [ -f $DOTFILES/bash/.bash_functions ]; then
	#. $DOTFILES/bash/.bash_functions 
#else
	#echo -e "Warning - Unable to source .bash_functions.\n\n"
#fi
