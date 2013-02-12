# Corrections
alias claer='clear;'
alias exot='exit'

#
alias create='touch'
alias find_text='grep -Rin --color'
alias find_usages='grep -ien --color'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias reload='source ~/.bash_profile'

# arch
alias install='sudo pacman -S $1'
alias remove='sudo pacman -Rs $1'
alias update='sudo pacman -Syu'
alias pkg_search='sudo pacman -Ss $1 $2'
alias pkg_info='sudo pacman -Si $1'
alias pkg_dependants='sudo pactree $1'

# git
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
