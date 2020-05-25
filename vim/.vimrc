" 
"        (_)                   
"  __   ___ _ __ ___  _ __ ___ 
"  \ \ / / | '_ ` _ \| '__/ __|
"   \ V /| | | | | | | | | (__ 
"    \_/ |_|_| |_| |_|_|  \___|
"                              
"  ============================                              
"                              
"

" ===== Vim Plug Configuration ======
"
" This section handles the configuration for the Plug plugin manager (https://github.com/junegunn/vim-plug).
"
" To Install plugins configured here, enter command mode and use PlugInstall
" To Update plugins configured here, enter command mode and use PlugUpdate
" To Remove deleted plugins removed from here, enter command mode and use PlugClean
"

" Specify the directory to be used for the plugins.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins 
Plug 'kaicataldo/material.vim'
Plug 'terryma/vim-multiple-cursors'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" ===================================

"let g:material_theme_style = 'darker'
colorscheme material

:let g:netrw_dirhistmax = 0

:set number                     " Show current line number
:set relativenumber             " Show relative line numbers
