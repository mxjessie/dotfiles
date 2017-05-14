filetype off
filetype plugin indent off
set nocp  " be youw twue sewf

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'altercation/vim-colors-solarized'
Plugin 'easymotion/vim-easymotion'
Bundle 'nathanielc/vim-tickscript' 
Plugin 'nvie/vim-flake8'
Bundle 'rodjek/vim-puppet'
Plugin 'scrooloose/NerdTree'
Plugin 'scrooloose/syntastic'
Plugin 'tmhedberg/SimpylFold'
Bundle 'tpope/vim-unimpaired'
Bundle 'Valloric/YouCompleteMe'
Bundle 'vimwiki/vimwiki'
Plugin 'VundleVim/Vundle.vim'
call vundle#end()

filetype plugin indent on
syntax on
colorscheme solarized
set background=dark
highlight ColorColumn ctermbg=0 guibg=lightgrey
let python_hilight_all=1

set encoding=utf8
set bs=2
" set clipboard=unnamed
set softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set cc=80 " colored ruler at 80 chars

" enable docstrings for folded code
let g:SimpylFold_docstring_preview=1

set ruler
set showmode
set number
set mouse+=a
set autochdir " automatically change cwd to file in buffer

" filetype configs
au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
au BufRead,BufNewFile *.pp set ft=puppet
au BufRead,BufNewFile */diary/*.wiki set spell
"au BufNewFile,BufRead *.py
"    \ set tabstop=4 |
"    \ set softtabstop=4 |
"    \ set shiftwidth=4 |
"    \ set textwidth=79 |
"    \ set expandtab |
"    \ set autoindent |
"    \ set fileformat=unix

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" syntastic: loc list and cute symbols
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_loc_list_height = 3
let g:syntastic_error_symbol = "💥"
let g:syntastic_warning_symbol = "🚫"
let g:syntastic_style_error_symbol = "🆖"
let g:syntastic_style_warning_symbol = "👎"

" powerline: use python3 or python2
if has('python3')
  python3 from powerline.vim import setup as powerline_setup
  python3 powerline_setup()
  python3 del powerline_setup
  set laststatus=2
elseif has('python')
  python from powerline.vim import setup as powerline_setup
  python powerline_setup()
  python del powerline_setup
  set laststatus=2
endif

" nerdtree: ^n to toggle, start if vim started w/o filename
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

command PPJson %!python -m json.tool
