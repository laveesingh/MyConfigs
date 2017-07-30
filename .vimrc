"Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Default cpp template
au BufNewFile *.cpp 0r ~/template.cpp

let mapleader = ","

" Cool configurations 
set tabstop=2
set softtabstop=2
set shiftwidth=2
set number
set expandtab
filetype off
filetype plugin indent on
syntax on
" set textwidth=79




" Displayed Properties
set showcmd
set cursorline
highlight LineNr ctermbg=0


" Other awesome properties
set wildmenu
set incsearch
set hlsearch
set pastetoggle=<F2>
nnoremap gV `[v`]

set mouse=a "mouse actions work

" Disable creation of backup files
set noswapfile
set nobackup
set nowritebackup
set colorcolumn=80
highlight ColorColumn ctermbg=0;

" Movement in insertion mode
imap <c-h> <Left>
imap <c-j> <Down>
imap <c-k> <Up>
imap <c-l> <Right>
imap <c-e> <ESC><c-e>a
imap <c-y> <ESC><c-y>a
imap <c-d> <ESC><c-d>a
imap <c-u> <ESC><c-u>a

imap <C-Space> <C-X><C-O>

"Tab movements
map <Leader>j <esc>:tabprevious<CR>
map <Leader>k <esc>:tabnext<CR>

"Better indentation
vnoremap < <gv
vnoremap > >gv

let mapleader=","
ab kkk n
ab lll b
inoremap jj <ESC>


" Split movements
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j


let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

execute pathogen#infect()
call pathogen#helptags()


" Plugin dependencies
" ctrlp, nerdtree, tagbar, fugitive, surroud, nerdcommenter, pathogen,
" closetag, multiple-cursors, youcompleteme
