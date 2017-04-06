set nocp  " be youw twue sewf
filetype off
filetype plugin indent off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'scrooloose/NerdTree'
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/syntastic'
Bundle 'altercation/vim-colors-solarized'
Plugin 'easymotion/vim-easymotion'
Plugin 'nvie/vim-flake8'
Bundle 'rodjek/vim-puppet'
Bundle 'nathanielc/vim-tickscript' 
Bundle 'vimwiki/vimwiki'
Plugin 'VundleVim/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-unimpaired'
call vundle#end()

filetype plugin indent on
syntax on
highlight ColorColumn ctermbg=0 guibg=lightgrey
set background=dark
let python_hilight_all=1
colorscheme solarized

set encoding=utf8
set bs=2
" set clipboard=unnamed
set softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set cc=80 " colored ruler at 80 chars
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
au BufRead,BufNewFile *.pp set ft=puppet

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" syntastic
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_loc_list_height = 3
let g:syntastic_error_symbol = "💥"
let g:syntastic_warning_symbol = "🚫"
let g:syntastic_style_error_symbol = "🆖"
let g:syntastic_style_warning_symbol = "👎"

" powerline: always visible
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2

" nerdtree: ^n to toggle, start if vim started w/o filename
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
