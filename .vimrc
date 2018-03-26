" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Default cpp template
"au BufNewFile *.cpp 0r ~/Templates/template.cpp

let mapleader = ","

" Cool configurations 
set backspace=indent,eol,start  " enable backspace key in several cases
set ruler  " show info in statusline
set tabstop=2
set softtabstop=2
set shiftwidth=2
set number
set expandtab
set t_Co=256  " force vim to use 256 colors
" set background=dark
filetype on
filetype plugin indent on
syntax on
set splitright
set splitbelow
" set textwidth=79

" Displayed Properties
set showcmd
colorscheme desert
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

" autoread on filechange
set autoread

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

let mapleader=","
"Tab movements
map <Leader>j <esc>:tabprevious<CR>
map <Leader>k <esc>:tabnext<CR>

"Better indentation
vnoremap < <gv
vnoremap > >gv


inoremap jj <ESC>

" Split movements
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j


" Ultisnips config
let g:UltiSnipsSnippetsDir        = '~/.vim/UltiSnips/'
"let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-h>"

" YouCompleteMe configs
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_auto_trigger = 1
let g:ycm_complete_in_comments = 1 
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_seed_identifiers_with_syntax = 1 
let g:ycm_collect_identifiers_from_comments_and_strings = 1 
let g:ycm_python_binary_path = '/usr/bin/python3'

" AirlineThemes configs

" syntastic configs
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

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
set foldlevel=0


execute pathogen#infect()
call pathogen#helptags()

" requires installation of monokai
"colorscheme monokai


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
