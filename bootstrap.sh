  #!/usr/bin/env bash
#https://github.com/holman/dotfiles/blob/master/script/bootstrap
set -e

#$DOTFILES="`pwd`"
DOTFILES=`find ~/ -maxdepth 1 -iname .dotfile* -type d`

informationMsg() {
 	printf "  [ \033[00;34m..\033[0m ] $1\n"
}

successMsg() {
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

failMsg() {
 	printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
}

installLinkedFile(){
	ln -s $1 $2
	successMsg "installed linked file $1 as $2"
}

createBackupDirectroy(){
	local PARENT_DIR='~/dotfiles_backup'
	local INSTANCE_DIR=`date +%d%m%Y_%H%M%S%N`	
	
	[[ ! -d "$PARENT_DIR" ]] || mkdir -p $PARENT_DIR
	[[ ! -d "${PARENT_DIR}/${INSTANCE_DIR}" ]] || mkdir "${PARENT_DIR}/${INSTANCE_DIR}"

	#if [[ ! -d ${BACKUP_DIR} ]]; then
		#echo "Creating backup directory"
	#	mkdir ${BACKUP_DIR}
	#fi

	#local INSTANCE_DIR=`date +%d%m%Y_%H%M%S%N`

	#if [[ ! -d ${BACKUP_DIR}/${INSTANCE_DIR} ]]; then
	#	#echo "Creating instance directory"
	#	mkdir ${BACKUP_DIR}/${INSTANCE_DIR}
	#fi
	
	echo ${BACKUP_DIR}/${INSTANCE_DIR}
}

createFileBackup(){
	#echo "Copying files for backup"
	mv "$1" "$2"
}

printf "\n:: Installing \033[00;34m.dotfiles\033[0m, please wait ...\n\n"

backup_location=$(createBackupDirectroy)
echo "${backup_location}"

for source in `find $DOTFILES -maxdepth 2 -name \*.symlink`
  do
    install_location="$HOME/`basename \"${source%.*}\"`"
    
    informationMsg "Attempting to install ${install_location} ..."

	if [[ ! -L "$install_location" ]]; then
		if [ -f "$install_location" ]; then
			informationMsg "... ${install_location} exists, creating backup ..."
			createFileBackup "${install_location}" "${backup_location}"
		fi

		installLinkedFile $source $install_location

	fi


    successMsg "... ${install_location} installed."
	
      #link_files $source $install_location

#    if [ -f $install_location ] || [ -d $install_location ]
    #then

      #overwrite=false
      #backup=false
      #skip=false

      #if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
      #then
        #user "File already exists: `basename $source`, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        #read -n 1 action

        #case "$action" in
          #o )
            #overwrite=true;;
          #O )
            #overwrite_all=true;;
          #b )
            #backup=true;;
          #B )
            #backup_all=true;;
          #s )
            #skip=true;;
          #S )
            #skip_all=true;;
          #* )
            #;;
        #esac
      #fi

      #if [ "$overwrite" == "true" ] || [ "$overwrite_all" == "true" ]
      #then
        #rm -rf $install_location
        #success "removed $install_location"
      #fi

      #if [ "$backup" == "true" ] || [ "$backup_all" == "true" ]
      #then
        #mv $install_location $install_location\.backup
        #success "moved $install_location to $install_location.backup"
      #fi

      #if [ "$skip" == "false" ] && [ "$skip_all" == "false" ]
      #then
        #link_files $source $install_location
      #else
        #success "skipped $source"
      #fi

    #else
      #link_files $source $install_location
    #fi

  done

  printf "\n\033[00;34m  .dotfiles\033[0m installation complete!\n\n"
