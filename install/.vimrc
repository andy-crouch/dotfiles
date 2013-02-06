" .vimrc - Standard .vimrc used to define a system indicator
" (used in .dotfiles/vim/vimrc).
fun! MySys()
	return "linux"
endfun

" updated the runtimepath env variable and
" source the .dotfiles/.vimrc
set runtimepath=~/.dotfiles/vim,$VIMRUNTIME
source ~/.dotfiles/.vimrc
