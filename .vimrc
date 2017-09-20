"Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Default cpp template
au BufNewFile *.cpp 0r ~/Templates/template.cpp

let mapleader = ","

" Cool configurations 
set tabstop=2
set softtabstop=2
set shiftwidth=2
set number
set expandtab
set t_Co=256  " force vim to use 256 colors
filetype off
filetype plugin indent on
syntax on
" set textwidth=79




" Displayed Properties
set showcmd
color desert
set cursorline
hi CursorLine term=bold cterm=bold ctermbg=16
highlight LineNr ctermbg=0


" Other awesome properties
set wildmenu
set incsearch
set hlsearch
set pastetoggle=<F2>
nnoremap gV `[v`]

" set mouse=a "mouse actions work

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


" Ultisnips config
"let g:UltiSnipsSnippetsDir        = $HOME.'/.vim/UltiSnips/'
"let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-h>"

" YouCompleteMe configs
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_complete_in_comments = 1 
let g:ycm_seed_identifiers_with_syntax = 1 
let g:ycm_collect_identifiers_from_comments_and_strings = 1 
let g:ycm_python_binary_path = '/usr/bin/python'

" AirlineThemes configs
let g:airline_theme='solarized'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" syntastic configs
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"let g:syntastic_javascript_checkers = ['eslint', 'jsxhint']
"let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

" vim-jsx configs
let g:jsx_ext_required = 0

execute pathogen#infect()
call pathogen#helptags()


" Plugin dependencies
" ctrlp, nerdtree, tagbar, fugitive, surroud, nerdcommenter, pathogen,
" closetag, multiple-cursors, youcompleteme
