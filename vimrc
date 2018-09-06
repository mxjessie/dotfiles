filetype off
filetype plugin indent off
set nocp  " be youw twue sewf

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'arcticicestudio/nord-vim'
Plugin 'chrisbra/Colorizer'
Plugin 'easymotion/vim-easymotion'
Plugin 'fatih/vim-go'
Plugin 'hashivim/vim-terraform'
Plugin 'hashivim/vim-vagrant'
Plugin 'nathanielc/vim-tickscript' 
Plugin 'rodjek/vim-puppet'
Plugin 'rust-lang/rust.vim'
Plugin 'sbl/scvim'
Plugin 'scrooloose/syntastic'
"Plugin 'sheerun/vim-polyglot'
"Plugin 'sickill/vim-monokai'
Plugin 'solarnz/thrift.vim'
Plugin 'tfnico/vim-gradle'
Plugin 'tmhedberg/SimpylFold'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'tssm/fairyfloss.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vimwiki/vimwiki'
Plugin 'VundleVim/Vundle.vim'
call vundle#end()

filetype plugin indent on
syntax on
set t_ut=  " fix 256 colors in tmux http://sunaku.github.io/vim-256color-bce.html

if has("termguicolors")
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"let g:nord_italic = 1
"let g:nord_italic_comments = 1
"let g:nord_comment_brightness = 12
colorscheme fairyfloss
set background=dark
hi Normal ctermbg=none
highlight ColorColumn ctermbg=0 guibg=lightmagenta
" don't really care about capitalization
set spellcapcheck=""
" just underlines for the spellchecker, please
hi clear SpellBad
hi clear SpellCap
hi SpellBad cterm=underline,bold
hi SpellCap cterm=underline,bold
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
autocmd FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.pp set ft=puppet
"autocmd BufNewFile,BufRead *.py
"    \ set tabstop=4 |
"    \ set softtabstop=4 |
"    \ set shiftwidth=4 |
"    \ set textwidth=79 |
"    \ set expandtab |
"    \ set autoindent |
"    \ set fileformat=unix

autocmd BufRead,BufNewFile */diary/*.wiki set spell

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" netrw: tree-style mode pls
let g:netrw_liststyle = 3

" syntastic: loc list and cute symbols
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_loc_list_height = 3
let g:syntastic_error_symbol = "💥"
let g:syntastic_warning_symbol = "🚫"
let g:syntastic_style_error_symbol = "🆖"
let g:syntastic_style_warning_symbol = "👎"
"let g:syntastic_error_symbol = "X"
"let g:syntastic_warning_symbol = "x"
"let g:syntastic_style_error_symbol = "!"
"let g:syntastic_style_warning_symbol = "?"

" 'local' is not posix-compliant sh but works mostly everywhere
let g:syntastic_sh_shellcheck_args="-e SC2039"

" enable the rust checker pls
autocmd FileType rust let g:syntastic_rust_checkers = ['rustc']

" vim-go settings
let g:syntastic_go_checkers = ['golint', 'govet']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"

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

" pretty json diffing
command PPJson %!python -m json.tool

" once a year i have to fiddle with line endings
command FTypeUnix e ++ff=unix
command FTypeDOS  e ++ff=dos
command FTypeMac  e ++ff=mac

command SaveAsUnix w ++ff=unix
command SaveAsDOS  w ++ff=dos
command SaveAsMac  w ++ff=mac

" vimwiki
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
let wiki_1.path_html = '~/vimwiki_html/'

" old github.io experiment
let wiki_2 = {}
let wiki_2.path = '~/blog/'
let wiki_2.path_html = '~/blog_html/'
let wiki_2.template_path = '~/blog/templates/'
let wiki_2.template_default = 'default'
let wiki_2.template_ext = '.html'

let g:vimwiki_list = [wiki_1, wiki_2]

" terraform
let g:terraform_align=1

" open today's journal page if started w/o filename
"if argc() == 0 && !exists("s:std_in")
"    autocmd StdinReadPre * let s:std_in=1
"    autocmd VimEnter * VimwikiMakeDiaryNote
"endif

" from https://stackoverflow.com/questions/749297/can-i-see-changes-before-i-save-my-file-in-vim
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
