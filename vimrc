set nocp  " behave on bsds
filetype off
set encoding=utf8
set bs=2
set clipboard=unnamed

syntax on
let python_hilight_all=1
set softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set cc=80 " colored ruler at 80 chars
highlight ColorColumn ctermbg=0 guibg=lightgrey
set background=dark
" enable docstrings for folded code
let g:SimpylFold_docstring_preview=1

"au BufNewFile,BufRead *.py
"    \ set tabstop=4 |
"    \ set softtabstop=4 |
"    \ set shiftwidth=4 |
"    \ set textwidth=79 |
"    \ set expandtab |
"    \ set autoindent |
"    \ set fileformat=unix

set ruler
set showmode
set number
set mouse+=a

"set foldmethod=indent
"set foldlevel=99

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Bundle 'altercation/vim-colors-solarized'
Bundle 'rodjek/vim-puppet'
call vundle#end()
filetype plugin indent on
au BufRead,BufNewFile *.pp setfiletype puppet
colorscheme solarized
