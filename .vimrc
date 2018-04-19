" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'wakatime/vim-wakatime'

call vundle#end()


set encoding=utf-8
let mapleader=","
inoremap jj <ESC>

imap <c-h> <Left>
imap <c-j> <Down>
imap <c-k> <Up>
imap <c-l> <Right>
imap <c-e> <ESC><c-e>a
imap <c-y> <ESC><c-y>a
imap <c-d> <ESC><c-d>a
imap <c-u> <ESC><c-u>a

imap <C-Space> <C-X><C-O>

map <Leader>j <esc>:tabprevious<CR>
map <Leader>k <esc>:tabnext<CR>

vnoremap < <gv
vnoremap > >gv

nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j

nnoremap gV `[v`]


" cool display properties
filetype on
filetype plugin indent on
syntax enable
colorscheme desert
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set wrap
set smarttab
set ruler
set number
set expandtab
set scrolloff=3
set t_Co=256
set splitright
set splitbelow
set backspace=indent,eol,start  " enable backspace key in several cases
set showcmd

set cursorline
set cursorcolumn
set colorcolumn=80
hi CursorLine term=bold cterm=bold ctermbg=234
hi CursorColumn term=bold cterm=bold ctermbg=234
hi ColorColumn ctermbg=234
hi LineNr ctermbg=236


" Other awesome properties
set wildmenu
set incsearch
set hlsearch
set smartcase
set pastetoggle=<F2>


" Disable creation of backup files
set noswapfile
set nobackup
set nowritebackup


" autoread on filechange
set autoread

" Plugins configs
exe 'source' '.vim_plugins_settings'
