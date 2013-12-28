function cl () {
   if [ $# = 0 ]; then
      cd && ls -la
   else
      cd "$*" && ls -la
   fi
}

function open()
{
	UNAME=`uname`
	OSLINUX="Linux"
	OSCYGWIN="CYGWIN_NT-6.1-WOW64"
	
	if [ "$UNAME" = "$OSLINUX" ]; then
		if [ "$1" = "" ]; then
			echo "open Failed, no file specified to open."
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

function expand_archive() 
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

function compress_archive()
{
    dirPriorToExe=`pwd`
    dirName=`dirname $1`
    baseName=`basename $1`
 
    if [ -f $1 ] ; then
        echo "It was a file change directory to $dirName"
        cd $dirName
        case $2 in
          tar.bz2)
                    tar cjf $baseName.tar.bz2 $baseName
                    ;;
          tar.gz)
                    tar czf $baseName.tar.gz $baseName
                    ;;
          gz)
                    gzip $baseName
                    ;;
          tar)
                    tar -cvvf $baseName.tar $baseName
                    ;;
          zip)
                    zip -r $baseName.zip $baseName
                    ;;
            *)
                    echo "Method not passed compressing using tar.bz2"
                    tar cjf $baseName.tar.bz2 $baseName
                    ;;
        esac
        echo "Back to Directory $dirPriorToExe"
        cd $dirPriorToExe
    else
        if [ -d $1 ] ; then
            echo "It was a Directory change directory to $dirName"
            cd $dirName
            case $2 in
                tar.bz2)
                        tar cjf $baseName.tar.bz2 $baseName
                        ;;
                tar.gz)
                        tar czf $baseName.tar.gz $baseName
                        ;;
                gz)
                        gzip -r $baseName
                        ;;
                tar)
                        tar -cvvf $baseName.tar $baseName
                        ;;
                zip)
                        zip -r $baseName.zip $baseName
                        ;;
                *)
                    echo "Method not passed compressing using tar.bz2"
                tar cjf $baseName.tar.bz2 $baseName
                        ;;
            esac
            echo "Back to Directory $dirPriorToExe"
            cd $dirPriorToExe
        else
            echo "'$1' is not a valid file/folder"
        fi
    fi
    echo "Done"
    echo "###########################################"
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
