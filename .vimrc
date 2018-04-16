" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


" important mappings and settings


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

" Ultisnips
let g:UltiSnipsSnippetsDir        = '~/.vim/UltiSnips/'
"let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-h>"

" YouCompleteMe
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_auto_trigger = 1
let g:ycm_complete_in_comments = 1 
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_seed_identifiers_with_syntax = 1 
let g:ycm_collect_identifiers_from_comments_and_strings = 1 
let g:ycm_python_binary_path = '/usr/bin/python3'


" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"let g:syntastic_javascript_checkers = ['eslint', 'jsxhint']
"let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

" vim-jsx configs
let g:jsx_ext_required = 0

" vim any-fold config
let anyfold_activate=1
set foldlevel=999


execute pathogen#infect()
call pathogen#helptags()


" Autostart NERDTree
"autocmd vimenter * NERDTree
"autocmd BufNew * NERDTree
map <Leader>t :NERDTreeToggle<CR>
let NERDTreeMapOpenInTab='<ENTER>'

" fzf settings
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})2

" autopep8 settings
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79
