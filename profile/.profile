# UI related environment variables
export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/nano
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/google-chrome-stable

# Enable ruby gems
PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
