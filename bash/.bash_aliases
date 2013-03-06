# Utility
alias list_functions="declare -F | cut -d' ' -f3"
alias list_aliases="compgen -a"
alias list_full_aliase_details="alias"

# Corrections
alias claer='clear;'
alias exot='exit'

#
alias create='touch'
alias find_text='grep -Rin --color'
alias find_usages='grep -ien --color'
alias l='ls -CF --color=auto'
alias la='ls -A --color=auto'
alias ll='ls -AlF --color=auto'
alias lsd='ls -l --color | grep "^d"'
alias reload='source ~/.bash_profile'

# Git
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
