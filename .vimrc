set nocompatible
let g:is_gui     = has('gui_running')
let g:is_mac     = has('mac') || has('macunix') || has('gui_macvim')
let g:is_nix     = has('unix') && !has('macunix') && !has("win32unix")
let g:is_macvim  = g:is_mac && g:is_gui && has('gui_macvim')
let g:is_ubuntu  = g:is_nix && system("uname -a") =~ "Ubuntu"
let g:is_windows = has('win16') || has('win32') || has('win64')
let g:is_posix   = 1 " enable better bash syntax highlighting
if g:is_macvim                | let g:ui_type = "MVIM"
elseif g:is_gui               | let g:ui_type = "GUI"
elseif exists("$TMUX")        | let g:ui_type = "TMUX"
elseif exists("$COLORTERM")   | let g:ui_type = "CTERM"
elseif exists("$TERM")        | let g:ui_type = "TERM"
else | let g:ui_type = "????" | endif
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction
function! PlugFromGist(id, name)
  Plug 'https://gist.github.com/'.id.'.git',
    \ { 'as': name, 'do': 'mkdir -p plugin; cp -f *.vim plugin/' }
endfunction
if filereadable(expand("~/.vimrc.pre")) | source ~/.vimrc.pre | endif
call plug#begin(expand("~/.vim/bundle"))
set autoread                      " watch for file changes
set noautochdir                   " do not auto change the working directory
set noautowrite                   " do not auto write file when moving away from it
set nofsync                       " allows OS to decide when to flush to disk
set scrolloff=5                 " keep lines off edges of the screen when scrolling
set sidescroll=1                " brings characters in view when side scrolling
set sidescrolloff=15            " start side-scrolling when n chars are left
scriptencoding utf-8
set encoding=utf-8 nobomb " BOM often causes trouble
set termencoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set nobackup                      " do not keep backup files - it's 70's style cluttering
set nowritebackup                 " do not make a write backup
set noswapfile                    " do not write annoying intermediate swap files
set directory=~/.vim/tmp/swaps,/tmp    " store swap files in one of these directories (in case swapfile is ever turned on)
set noerrorbells                  " don't beep
set visualbell t_vb=              " don't beep, remove visual bell char
set timeout                     " timeout on :mappings and key codes
set timeoutlen=600              " timeout duration should be sufficient to type the mapping
set ttimeoutlen=50              " timeout duration should be small for keycodes
set lazyredraw
set number
set nomodeline
set noexrc
set secure
if exists("&cryptmethod") | set cryptmethod=blowfish | endif
runtime macros/matchit.vim
if has('mouse')
  set mouse=a
  set mousehide        " hide mouse pointer when typing
endif
let mapleader      = ","     " change mapleader key from / to ,
let g:mapleader    = ","     " some plugins may require this variable to be set
let maplocalleader = "\\"    " used inside filetype settings
nnoremap ; :
nnoremap 0 ^
nnoremap ^ 0
if &term =~# '^screen'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set virtualedit=onemore
set backspace=indent,eol,start
set fileformats="unix,dos,mac"
set formatoptions-=t            " do not format just about any type of text, esp. source code
set formatoptions+=n            " recognize numbered lists when formatting
set formatoptions+=1            " don't break a line after a one-letter word
set tabstop=2                   " a tab is two spaces
set softtabstop=2               " when <BS>, pretend tab is removed, even if spaces
set expandtab                   " expand tabs, by default
set nojoinspaces                " prevents two spaces after punctuation on join
set nowrap                      " don't wrap lines
set linebreak                   " break long lines at words, when wrap is on
set whichwrap=b,s,h,l,<,>,[,]   " allow <BS> & cursor keys to move to prev/next line
set showbreak=↪                 " string to put at the starting of wrapped lines
set textwidth=80                " wrap after this many characters in a line
set list                        " show invisible characters like spaces
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:·
Plug 'tpope/vim-surround'
Plug 'Lokaltog/vim-easymotion'
if has("diff") | set diffopt+=iwhite | endif
if has("diff")
  function! DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  endfunction
  nnoremap <leader>ds :call DiffWithSaved()<CR>
endif
set cursorline
set nocursorcolumn
if has('syntax') | set colorcolumn=80,100,120 | endif
nnoremap <leader>tcc :set cursorcolumn!<CR>
if g:is_gui
  let &guicursor = substitute(&guicursor, 'n-v-c:', '&blinkon0-', '')
endif
Plug 'terryma/vim-multiple-cursors'
set number
set numberwidth=4
"nnoremap <leader>trn :set relativenumber!<cr>
"augroup relative_line_numbers
  "au!
  "autocmd FocusLost,BufLeave,InsertEnter   * if &number | :setl norelativenumber | endif
  "autocmd FocusGained,BufEnter,InsertLeave * if &number | :setl relativenumber   | endif
"augroup end
Plug 'tpope/vim-fugitive'


augroup git_files
  au!
  autocmd BufRead,BufNewFile GHI_* set ft=gitcommit
  autocmd FileType gitcommit setlocal spell textwidth=72
augroup end
set wildmenu
set wildmode=list:longest,full      " show a list when pressing tab, then longest common part and then full name.
set wildignore+=*/.hg/*,*/.svn/*    " stuff to ignore when tab completing
set wildignore+=*vim/backups*       " ...
set wildignore+=*/smarty/*          " ...
set wildignore+=*/node_modules/*    " ...
set wildignore+=*/.sass-cache/*     " ...
set wildignore+=*/tmp/*,tmp/**      " ...
set wildignore+=*/out/**,log/**     " ... phew!!
set suffixes+=.swo,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.DS_Store,.class,.so
set suffixes+=.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll,.zip
set suffixes+=.gem,.pdf,.avi,.mkv,.psd
Plug 'kien/ctrlp.vim'
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_cache_dir = expand("~/.vim") . "/tmp/cache/ctrlp"
if executable("ag") | let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' | endif
if executable("pt") | let g:ctrlp_user_command = 'pt %s -l --nocolor -g ""' | endif
nnoremap <leader>. :CtrlPTag<cr>
let g:netrw_silent = 1
let g:netrw_quiet  = 1
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
let NERDTreeWinPos = "left"        " nerdtree should appear on left
let NERDTreeWinSize = 25           " nerdtree window must be 25 char wide
let NERDTreeStatusLine = -1        " do not use the default status line
let NERDTreeDirArrows          = 1 " display fancy arrows instead of ASCII
let NERDTreeMinimalUI          = 0 " I don't like the minimal UI, nerdtree!
let NERDTreeShowFiles          = 1 " show files as well as dirs
let NERDTreeShowHidden         = 1 " show hidden files, too.
let NERDTreeShowBookmarks      = 1 " oh, and obvously, the bookmarks, too.
let NERDTreeCaseSensitiveSort  = 1 " sorting of files should be case sensitive
let NERDTreeRespectWildIgnore  = 1 " ignore files ignored by `wildignore`
let NERDTreeChDirMode          = 2 " change CWD when tree root is changed
let NERDTreeMouseMode          = 2 " use single click to fold/unfold dirs
let NERDTreeQuitOnOpen         = 0 " do not quit on opening a file from tree
let NERDTreeAutoDeleteBuffer   = 1 " delete buffer when deleting the file
let NERDTreeHighlightCursorline= 1 " highlight the current line in tree
let NERDTreeBookmarksFile      = expand("~/.vim") . "/tmp/bookmarks"
let g:nerdtree_tabs_open_on_gui_startup=0
let g:nerdtree_tabs_open_on_console_startup=0
let NERDTreeSortOrder = [ '\/$', '\.rb$', '\.php$', '\.py$',
      \ '\.js$', '\.json$', '\.css$', '\.less$', '\.sass$', '\.scss$',
      \ '\.yml$', '\.yaml$', '\.sh$', '\..*sh$', '\.vim$',
      \ '*', '.*file$', '\.example$', 'license', 'LICENSE', 'readme', 'README',
      \ '\.md$', '\.markdown$', '\.rdoc$', '\.txt$', '\.text$', '\.textile$',
      \ '\.log$', '\.info$' ]
let NERDTreeIgnore = [ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
      \ '\.so$', '\.egg$', '^\.git$', '^\.hg$', '^\.svn$', '^\.DS_Store',
      \ '\.png$', '\.jpg$', '\.jpeg$', '\.bmp$', '\.svg$', '\.gif$',
      \ '\.zip$', '\.gz$', '\.lock$', '\.swp$', '\.bak$', '\~$' ]
nmap <leader>ntf <leader>nto<C-w>p:NERDTreeFind<CR>
nmap <leader>ntc :NERDTreeClose<CR>
nmap <leader>nto :NERDTreeFocus<CR>:vertical resize 25<CR>
if !g:is_windows
  if !empty('$SHELL')
    set shell=$SHELL\ -l
  elseif executable('zsh')
    set shell=zsh\ -l
  elseif executable('bash')
    set shell=bash\ -l
  else
    set shell=/bin/sh
  endif
endif
set title
set ttyfast
if &t_Co > 2 && &t_Co < 16
  set t_Co =16
elseif &t_Co > 16
  set t_Co =256
endif
set ignorecase                  " makes searches ignore case
set smartcase                   " if pattern has uppercase, be case-sensitive
set wrapscan                    " search continues after the end of file
set magic                       " use magic mode when searching/replacing
set gdefault                    " search/replace globally (on a line) by default
set incsearch                   " show search matches as you type
if g:is_gui || &t_Co > 2 | set hlsearch | endif
Plug 'vim-scripts/IndexedSearch'
nmap <silent> <leader><cr> :nohlsearch<CR>
set pastetoggle=<F2>
function! PasteWithPasteMode(keys)
  if &paste
    execute("normal " . a:keys)
  else
    set paste
    execute("normal " . a:keys)
    set nopaste
  endif
endfunction
nnoremap <silent> <leader>p :call PasteWithPasteMode('p')<CR>`[v`]=`[v`]
nnoremap <silent> <leader>P :call PasteWithPasteMode('P')<CR>`[v`]=`[v`]
if g:is_nix && has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  set clipboard+=unnamed
endif
if has('persistent_undo')
  set undofile                  " have a long persisting undo data
  set undolevels=1000           " Maximum number of changes that can be undone
  set undoreload=10000          " Maximum number lines to save for undo on a buffer reload
  set undodir=~/.vim/tmp/undo,/tmp
endif
set hidden
set splitbelow              " puts new split windows to the bottom of the current
set splitright              " puts new vsplit windows to the right of the current
set equalalways             " split windows are always of eqal size
set switchbuf=useopen,split " use existing buffer or else split current window
set winheight=7             " squash splits or windows to a separator when minimized
set winwidth=30             " squash splits or windows to a separator when minimized
set winminheight=3          " squash splits or windows to a status bar only when minimized
set winminwidth=12          " squash splits or windows to a separator when minimized
augroup resize_splits
  au!
  au VimResized * :wincmd =
augroup end
set tabpagemax=15
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
nmap <silent> <leader>qf :QFix<CR>
map <C-W><C-=> <C-W>=
map <C-W><C-M> <C-W>999+<C-W>999>
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-W><C-H> <C-W>h<C-W><bar>
map <C-W><C-J> <C-W>j<C-W>_
map <C-W><C-K> <C-W>k<C-W>_
map <C-W><C-L> <C-W>l<C-W><bar>
map <C-W><C-T> <C-W>T
map <C-W><space> <C-W>t<C-W>J<C-W>t<C-W>H
nnoremap <leader>el :buffers<CR>:buffer<Space>
nnoremap <leader>e3 :e#
nnoremap <leader>wh <C-w>s
nnoremap <leader>wv <C-w>v<C-w>l
nnoremap <leader>ph :execute 'rightbelow split' bufname('#')<cr>
nnoremap <leader>pv :execute 'leftabove vsplit' bufname('#')<cr>
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
if has('viminfo')
  set viminfo='500,:100,@100,/20,f1,%,<200
endif
if has('mksession')
  set sessionoptions+=resize
endif
set history=1000
augroup restore_cursor
  au!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
                        \ | exe "normal! g`\"" | endif
augroup end
vnoremap <leader>qv :normal @v
nnoremap <F9> mzggg?G'z
command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')
nnoremap J mjJ`j
inoremap jj <Esc>
"inoremap jk <Esc>
noremap j gj
noremap k gk
nnoremap <Tab> %
vnoremap <Tab> %
noremap <leader>wq :q<CR>
nnoremap <leader>fs :w!<CR>
nnoremap <silent> <leader>W  mw:%s/\v<C-v><C-m>//e<CR>:retab<CR>:%s/\s\+$//e<CR>:nohlsearch<CR>:w<CR>`w
nnoremap <leader><leader> <C-^>
cmap w!! w !sudo tee % >/dev/null
map <leader>er :e **/*
map <leader>ew :e ./
map <leader>es :sp ./
map <leader>ev :vsp ./
map <leader>et :tabe ./
nmap <leader>b= ggVG=''
vnoremap < <gv
vnoremap > >gv
vmap Q gq
nmap Q gqap
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>
nnoremap <F8> "=strftime("%d-%m-%y %H:%M:%S")<CR>P
inoremap <F8> <C-R>=strftime("%d-%m-%y %H:%M:%S")<CR>
cmap Tabe tabe
if has("user_commands")
  command! -bang -nargs=* -complete=file E e<bang> <args>
  command! -bang -nargs=* -complete=file W w<bang> <args>
  command! -bang -nargs=* -complete=file Wq wq<bang> <args>
  command! -bang -nargs=* -complete=file WQ wq<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
endif
set iskeyword-=.
set iskeyword-=#
set iskeyword-=-
set synmaxcol=800
if g:is_gui || &t_Co > 2 | syntax on | endif
set showmatch
set matchtime=2    " show matching parenthesis for 0.2 seconds
hi MatchParen ctermbg=lightblue guibg=lightblue
set formatoptions+=cro
set formatoptions+=q
if v:version > 730
  silent! set formatoptions+=j " remove comment markers when joining lines
endif
nnoremap - :Switch<cr>
set tags+=./tags,tags;/         " find and load tags file up until root
nnoremap <silent> <leader>j :tnext<cr>zt
nnoremap <silent> <leader>J :tprev<cr>zt
nnoremap <silent> <leader>k :pop<cr>zt
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
augroup setup_whitespace | au! | augroup end
augroup exceeded_text_width | au! | augroup end
nnoremap <Space> za
vnoremap <Space> za
Plug 'sheerun/vim-polyglot'
augroup detect_filetypes | au! | end
set completeopt+=menu,longest     " select first item, follow typing in autocomplete
set complete=.,w,b,u,t            " do lots of scanning on tab completion,  FIXME?
set pumheight=10                   " Keep a small completion window
if has('conceal')
  set conceallevel=2
  set concealcursor=i
endif
set completeopt+=preview
augroup omni_complete
  au!
  if exists('+omnifunc')
    autocmd filetype * if &omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif
  end
augroup end
Plug 'python-mode/python-mode'
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0
augroup omni_complete
  if exists('+omnifunc')
    autocmd filetype python setlocal omnifunc=pythoncomplete#Complete
  end
augroup end
augroup setup_whitespace
  au filetype python   setl ts=4 sw=4 sts=4 tw=80 et
augroup end
augroup exceeded_text_width
  au filetype python match ErrorMsg '\%>80v.\+'
augroup end
augroup jobs_and_tasks
  au BufRead,BufEnter *.py if executable(expand("%:p")) &&
        \ ( &makeprg == "make" ) | setl makeprg=%:p | endif
augroup end
Plug 'pangloss/vim-javascript'        " Javascript
Plug 'mxw/vim-jsx'                    " JSX templates
Plug 'w0rp/ale'
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed='never'
augroup detect_filetypes
  au BufNewFile,BufRead *.json setl ft=json
  au BufNewFile,BufRead *.coffee{,script} setl ft=coffee
  au syntax   javascript         setl syntax=jquery
  au filetype json,javascript    setl syntax=javascript
augroup end
augroup riot_js
  au!
  au BufNewFile,BufRead *.js.tag setl ft=html
  au filetype html :call SyntaxRange#Include("<style>", "</style>", "css")
  au filetype html :call SyntaxRange#Include("<style.*sass.*>", "</style>", "scss")
  au filetype html :call SyntaxRange#Include("<style.*scss.*>", "</style>", "scss")
  au filetype html :call SyntaxRange#Include("<style.*less.*>", "</style>", "less")
  au filetype html :call SyntaxRange#Include("<script>", "</script>", "javascript")
  au filetype html :call SyntaxRange#Include("<script.*coffee.>", "</script>", "coffee")
  au filetype html :call SyntaxRange#Include("<script.*coffeescript.>", "</script>", "coffee")
augroup END
augroup omni_complete
  if exists('+omnifunc')
    autocmd filetype javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  end
augroup end
augroup setup_whitespace
  au filetype json,javascript,coffee  setl ts=2 sw=2 sts=2 tw=80 et
  au filetype coffee,javascript setl listchars=trail:·,extends:#,nbsp:·
augroup end
augroup jobs_and_tasks
  au BufRead,BufEnter *.js if executable(expand("%:p")) &&
        \ ( &makeprg == "make" ) | setl makeprg=%:p | endif
augroup end
Plug 'othree/html5.vim'                 " html 5
Plug 'hail2u/vim-css3-syntax'           " CSS3
Plug 'cakebaker/scss-syntax.vim'        " SCSS
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}
Plug 'skwp/vim-html-escape'
augroup detect_filetypes
  au BufNewFile,BufRead *.less setl ft=less
  au BufNewFile,BufRead *.scss setl ft=scss
  au BufNewFile,BufRead *.sass setl ft=sass
augroup end
augroup omni_complete
  if exists('+omnifunc')
    autocmd filetype css  setlocal omnifunc=csscomplete#CompleteCSS
    autocmd filetype html setlocal omnifunc=htmlcomplete#CompleteTags
  end
augroup end
augroup setup_whitespace
  au filetype html,xhtml,haml     setl ts=2 sw=2 sts=2 tw=0  et
  au filetype css,less,sass,scss  setl ts=2 sw=2 sts=2 tw=80 et
augroup end
augroup omni_complete
  if exists('+omnifunc')
    autocmd filetype c setlocal omnifunc=ccomplete#Complete
  end
augroup end
augroup jobs_and_tasks
  au BufRead,BufEnter *.c,*.cpp if executable(expand("%:p")) &&
        \ ( &makeprg == "make" ) | setl makeprg=%:p | endif
augroup end
augroup detect_filetypes
  au BufNewFile,BufRead *.yml,*.yaml setl ft=yaml
  au BufNewFile,BufRead *.md,*.mdown,*.markdown setl ft=ghmarkdown
augroup end
augroup yaml_front_matter
  au!
  au filetype ghmarkdown,textile syntax region frontmatter start=/\%^---$/ end=/^---$/
  au filetype ghmarkdown,textile highlight link frontmatter Comment
augroup end
augroup omni_complete
  if exists('+omnifunc')
    autocmd filetype ghmarkdown setlocal omnifunc=htmlcomplete#CompleteTags
  end
augroup end
augroup setup_whitespace
  au filetype rst        setl ts=4 sw=4 sts=4 tw=74 et
  au filetype yaml       setl ts=2 sw=2 sts=2 tw=72 et
  au filetype ghmarkdown setl ts=4 sw=4 sts=4 tw=72 et
  au filetype textile    setl ts=4 sw=4 sts=4 tw=72 et
  au filetype ghmarkdown,textile,text,rst setl nolist
augroup end
augroup text_files
  au!
  au filetype ghmarkdown             setl formatoptions+=w
  au filetype ghmarkdown,textile,rst setl formatoptions+=qat
  au filetype ghmarkdown,textile,rst setl formatoptions-=cro
  au filetype ghmarkdown,textile,rst setl wrap wrapmargin=2
augroup end
augroup exceeded_text_width
  au filetype rst match ErrorMsg '\%>74v.\+'
augroup end
augroup jobs_and_tasks
  au filetype rst setl makeprg=rst2html.py\ %\ /tmp/%:r.html\ &&\ open\ /tmp/%:r.html
  au filetype ghmarkdown setl makeprg=rdiscount\ %\ >\ /tmp/%:r.html\ &&\ open\ /tmp/%:r.html
augroup end
augroup detect_filetypes
  au BufNewFile,BufRead *vimrc,*.vim setl ft=vim
  au BufNewFile,BufRead *zshrc,*zprofile,*zlogout,*zlogin,*zshenv,*.zsh-theme setl ft=sh
augroup end
augroup setup_whitespace
  au filetype sh  setl ts=2 sw=2 sts=2 tw=72 et
  au filetype vim setl ts=2 sw=2 sts=2 tw=72 et
augroup end
function! AdditionalHelpForVim()
  let g:investigate_use_url_for_vim = 1
  call investigate#Investigate()
  let g:investigate_use_url_for_vim = 0
endfunction
augroup documentor_vim | au!
  au filetype vim silent! nmap <silent> gK :call AdditionalHelpForVim()<CR>
augroup end
augroup jobs_and_tasks
  au filetype sh  setl makeprg=chmod\ +x\ %:p\ &&\ %:p
augroup end
nmap <leader>e. :vs<CR>:e $MYVIMRC<CR>
nmap <leader>bs :source %<CR>:set foldenable<CR>:e!<CR>
vmap <leader>bs y:@"<CR>:echo 'Sourced the selected range.'<CR>
augroup vim_plugin_browser
  au!
  au filetype vim noremap <buffer> <F6>
        \ :normal ^f'ahttps://github.com/<Esc>:normal ^f'lgxu<CR>
augroup end
augroup help_window
  au!
  au filetype help nnoremap <buffer><cr> <c-]>
  au filetype help nnoremap <buffer><bs> <c-T>
  au filetype help nnoremap <buffer>q    :q<CR>
augroup end
augroup omni_complete
  if exists('+omnifunc')
    autocmd filetype xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd filetype java setlocal omnifunc=javacomplete#Complete
    autocmd filetype haskell setlocal omnifunc=necoghc#omnifunc
  end
augroup end
augroup setup_whitespace
  au filetype make  setl noet " make uses real tabs
augroup end
let g:dotfiles_dir = '~/Code/dotcastle'
"let g:enable_tabline = 1
set cmdheight=1                 " use a status bar that is 2 rows high
set laststatus=2                " tell VIM to always put a status line in
set report=0
set shortmess+=filmnrxoOtT
set noshowmode
if has('cmdline_info')
  set ruler                     " Show the ruler
  set showcmd                   " show (partial) command in the last line of the screen
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
endif
if has('statusline') && !exists('g:loaded_airline')
  set stl=\ \ \[_%{mode()}_]\ \ \ [%Y/%{&ff}]\ %F\ %m%r\
        \ %=[%{g:ui_type}]\ %-17.(%l,%c%V%)\ %p\%\%\ \ \ %LL\ TOTAL
endif
Plug 'bling/vim-airline'
let g:airline_inactive_collapse = 1
let g:airline_section_y = "%{airline#util#wrap(airline#parts#ffenc() . ' ' . g:ui_type, 0)}"
let g:airline_powerline_fonts = 1
"if g:enable_tabline && exists('g:loaded_airline')
  "let g:airline#extensions#tabline#enabled = 1
  "let g:airline#extensions#tabline#show_buffers = 0
  "let g:airline#extensions#tabline#tab_min_count = 1
  "let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
  "let g:airline#extensions#tabline#show_tab_type = 0
  "let g:airline#extensions#tabline#show_close_button = 1
  "let g:airline#extensions#tabline#left_sep = '>>'
  "let g:airline#extensions#tabline#left_alt_sep = '>>'
  "let g:airline#extensions#tabline#right_sep = '<<'
  "let g:airline#extensions#tabline#right_alt_sep = '<<'
  "let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  "let g:airline#extensions#tabline#excludes = ['*NERD*', '*Tagbar*', 'ControlP']
"endif
augroup startup_screen
  au User Startified AirlineRefresh
augroup end
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf'
Plug 'tell-k/vim-autopep8'
Plug 'wakatime/vim-wakatime'
Plug 'posva/vim-vue'
let g:vue_disable_pre_processors=1
Plug 'prettier/vim-prettier'
Plug 'styled-components/vim-styled-components'
Plug 'Valloric/YouCompleteMe'
Plug 'pseewald/vim-anyfold'
Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
Plug 'SirVer/ultisnips'
Plug 'chrisbra/Colorizer'
Plug 'mileszs/ack.vim'
call plug#end()
if filereadable(expand("~/.vimrc.local")) | source ~/.vimrc.local | endif
autocmd! bufwritepost .vimrc source %
let mapleader=","
inoremap jj <ESC>
nnoremap nn :cn<return>
nnoremap pp :cp<return>
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
filetype on
filetype plugin indent on
syntax on
set tabstop=2
set softtabstop=2
set shiftwidth=2
set ruler  " show info in statusline
set number
set expandtab
set t_Co=256  " force vim to use 256 colors
set splitright
set splitbelow
set showcmd
set cursorline
set cursorcolumn
set colorcolumn=80
set autoindent     " always set autoindenting on
set shiftwidth=2   " number of spaces to use for autoindenting
"set copyindent     " copy the previous indentation on autoindenting
set smartindent
set shiftround     " use multiple of 'sw' when indenting with '<' and '>'
set smarttab       " insert tabs on start of line acc to 'sw' not 'ts'
hi CursorLine term=bold cterm=bold ctermbg=234
hi ColorLine ctermbg=234
hi CursorColumn term=bold cterm=bold ctermbg=234
hi ColorColumn ctermbg=234
hi LineNr ctermbg=236
colorscheme molokai
set wildmenu
set incsearch
set hlsearch
set pastetoggle=<F2>
set noswapfile
set nobackup
set nowritebackup
set autoread


function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? '['. fnamemodify(fnamemodify(bufname, ':h'), ':t') . '/'. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let s .= '%=%999XX'
  endif
  return s
endfunction
set tabline=%!Tabline()


let g:UltiSnipsSnippetsDir        = '~/.vim/UltiSnips/'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-h>"
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_auto_trigger = 1
let g:ycm_complete_in_comments = 1 
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_seed_identifiers_with_syntax = 1 
let g:ycm_collect_identifiers_from_comments_and_strings = 1 
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:jsx_ext_required = 0
let anyfold_activate=1
set foldlevel=999
execute pathogen#infect()
call pathogen#helptags()
map <Leader>t :NERDTreeToggle<CR>
let NERDTreeMapOpenInTab='<ENTER>'
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})2
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79
let g:prettier#config#semi = 'false'
autocmd bufwritepre *.js Prettier
autocmd bufwritepre *.vue Prettier
autocmd bufwritepost *.py Autopep8
