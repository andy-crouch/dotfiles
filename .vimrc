"///////////////////////////////////////////////////////////////////////////////
"//
"// vimrc - Vim configuration file.
"// ================================
"//
"// Version	:: 1.1
"//
"// About
"// -----
"//
"//	This is my (evolving) vimrc file.  The aim of the file
"// is to provide centralised settings which can be managed
"// and loaded from my personal Dropbox folder. I would like 
"// to thank Amir Salihefendic (http://goo.gl/tWgJF) whose
"// blog post gave me the idea of storing my Vim settings this
"// way.
"//
"// Setup
"// -----
"//
"// In order to use the same approach I do you will need a Dropbox folder on 
"// the target machine.  I use a directory within my Dropbox folder called
"// /VimSettings within which I store my Vim runtime file and directory
"// structure (see http://goo.gl/MpOnF for full details of the Vim 
"// runtime directory structure).
"//
"// I then modify my ~/.vimrc on each machine to contain the following ...
"//
"//     " base .vimrc used to define current system & load settings from 
"//     " personal Dropbox location ...
"//     fun! MySys()
"//         return \"linux\"
"//     endfun
"//
"//     set runtimepath=~/Dropbox/VimSettings,$VIMRUNTIME
"//     source ~/Dropbox/VimSettings/vimrc
"//
"// You should, obviously, change the path (~/Dropbox/VimSettings) to the
"// path of your settings folder within your Dropbox folder. (Also note,
"// the \ character of the return line is only required for commenting here
"// and should be removed). The value returned by MySys() is used throughout
"// the file to provide tailored functionality to be applied on a system by
"// system basis and to allow for the different syntax for various platforms.
"//
"// Configuration Sections
"// ----------------------
"//
"// I have split my file into the following sections :
"//
"// 	=> General settings
"//	    => Status line settings
"//	    => Font and colours settings 
"//	    => Key mappings
"//	    => Functions
"//
"// Plugin's
"// --------
"//
"// I currently use the follow plugin's which may be referenced within my
"// vimrc :
"//
"// 	=> comments.vim - Used to comment and uncomment lines of a file with the
"//	                      file types associated comment character.  
"//					      (See http://goo.gl/Ugipv)
"// Version History
"// ---------------
"//
"// > v1.1	:: Added my plugin's.
"// > v1.0	:: Created from old file and implement new 
"//			   Dropbox based central, controlled settings
"//			   basis.  Tidied up and made useful.
"// 
"///////////////////////////////////////////////////////////////////////////////

"///////////////////////////////////////////////////////////////////////////////
"// General settings ...
"///////////////////////////////////////////////////////////////////////////////

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

let mapleader=","				" remap the leader key to ,
set nocompatible 				" turn off vi compatibility
set autoindent 					" set on autoindent 
set smartindent 				" set on smart indent
set showmatch 					" match paired brackets
set mat=2 						" how many tenths of a second to blink when matching
set vb t_vb= 					" don't bleep just flash on error
set ruler 						" show a position marker
set number 						" show line numbers
set tabstop=4 					" set the tabwidth to 4 spaces
set shiftwidth=4				" (see above ...)
set nowrap 						" do not wrap lines
set autoread 					" set to auto read when a file is changed from the outside
set ignorecase 					" ignore case when searching
set smartcase					" if the search patten has an uppercase character then the search becomes case sensitive
set spellsuggest=10 			" set the max number of suggestions for spelling mistakes to 10 in the list
set backspace=indent,eol,start	" enable backspacing over everything in insert mode.
set showcmd						" display incomplete commands
set incsearch					" do incremental searching
set history=50					" keep 50 lines of command line history
set hlsearch					" enable highlighting for the last used search patten.

" enable mouse support for the terminal.
if has('mouse')
  set mouse=a
endif

" switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Reload the vimrc file from the Dropbox folder when edited ...
if MySys() == "cygwin"
elseif MySys() == "windows"
	autocmd! bufwritepost vimrc source c:\Documents\ and\ Settings\Andy\My\ Documents\My\ Dropbox\Config\VimSettings\vimrc
elseif MySys() == "linux"
	autocmd! bufwritepost vimrc source ~/Dropbox/Config/VimSettings/vimrc
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"///////////////////////////////////////////////////////////////////////////////
"// Status line settings ...
"///////////////////////////////////////////////////////////////////////////////

" improved status line (FileName Format[] Type[] ASCII[] HEX[] POS[] % LEN[]) 
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]
set laststatus=0

"///////////////////////////////////////////////////////////////////////////////
"// Font and colours settings ...
"///////////////////////////////////////////////////////////////////////////////

syntax on 			" Switch on syntax highlighting
 
" Set font according to system
if MySys() == "cygwin"
	set gfn=Meslo:h14
	set shell=/bin/bash
elseif MySys() == "windows"
	"set gfn=ProggyCleanTT:h12:cDEFAULT
	set gfn=Meslo\ LG\ S\ DZ:h9:cDEFAULT
elseif MySys() == "linux"
	set gfn=Lucida\ Console\ 8
	"set gfn=Meslo\ LG\ S\ DZ\ 8
	set shell=/bin/bash
endif

if has("gui_running")
	" UI specific options for GVim ...
	" ... default to hide the GVim toolbar (see Key mappings for toggle) ...
	set guioptions-=T 
	" ... set colour scheme ...
	colorscheme jellybeans
else
	" UI specific options for VIM ...
	" ... set colour scheme ...
	if MySys() == "cygwin"
		" Cygwin apparently only supports 8 (!) colours, back to a default 
		" for now ...
		colorscheme desert 
	else
		set t_Co=256
		let g:jellybeans_use_lowcolor_black = 0
		colorscheme jellybeans
	endif
endif

"///////////////////////////////////////////////////////////////////////////////
"// Key mappings ...
"///////////////////////////////////////////////////////////////////////////////

" ssb in normal mode shows the improved status line ...
map ssb <ESC>:set laststatus=2<CR>	
" hsb in normal mode hides the improved status line ...
map hsb <ESC>:set laststatus=0<CR>   
" stb shows GVims toobar ...
map stb <ESC>:set guioptions+=T<CR> 
" htb hides GVims toolbar (default, see above) ...
map htb <ESC>:set guioptions-=T<CR> 
" F3 toggles spelling ....
map <F3> <Esc>:setlocal spell! spelllang=en_gb<CR>

"CtrlP key mappings (map command to open in pwd) ...
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP ..'

" In windows provide standard windows shortcut to the System menu
if MySys() == "windows"
	if has("gui")
	  noremap <M-Space> :simalt ~<CR>
	  inoremap <M-Space> <C-O>:simalt ~<CR>
	  cnoremap <M-Space> <C-C>:simalt ~<CR>
	endif
endif	

"///////////////////////////////////////////////////////////////////////////////
"// Functions ...
"///////////////////////////////////////////////////////////////////////////////


