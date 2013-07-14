" VIM CONFIGURATION 
"
" Maintained by Eric Schwabe <eric.r.schwabe@boeing.com>
"
" https://github.com/nvie/vimrc/blob/master/vimrc
" http://www.vi-improved.org/vimrc.php
" http://nvie.com/posts/how-i-boosted-my-vim/
" 
" To start vim without using this .vimrc file, use:
" vim -u NORC
"
" To start vim without loading any .vimrc or plugins, use:
" vim -u NONE
"

" Use vim settings rather than vi
" Must be first since it affects other options
set nocompatible

set laststatus=2
set noshowmode
set encoding=utf-8
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors

let NERDTreeStatusline=''

filetype off

set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/powerline', { 'rtp': 'powerline/bindings/vim/' }
Bundle 'daylerees/colour-schemes', { 'rtp': 'vim-themes/' }
Bundle 'tomasr/molokai'
Bundle 'scrooloose/nerdtree'
Bundle 'SirVer/ultisnips'
Bundle 'kien/ctrlp.vim'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
"Bundle 'fholgado/minibufexpl.vim'
"Bundle 'Valloric/YouCompleteMe'

filetype plugin indent on

set autowriteall
set guioptions=-m
set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 11
colorscheme molokai

" Change mapleader from \ to ,
let mapleader=","

" GENERAL
" {{{
  set noexrc                        " do not use local directory config (.vimrc)
  set novisualbell                  " turn off visual bell
  set noerrorbells                  " disable beep and screen flashes
  set hidden                        " hide buffers instead of closing them
  
  set nobackup                      " disable backup files
" set backupdir=~/.vim/backup       " set backup file directory
  set noswapfile                    " disable swap files
  set directory=~/.vim/tmp,/tmp     " set swap file directory
" set autochdir                     " always switch to current file directory
  
  set mouse=a                       " allow mouse usage (terminal)
  set shortmess=atTI                " a - terse messages (like [+] instead of [Modified]
                                    " t - truncate file names
                                    " I - no intro message when starting vim fileless
                                    " T - truncate long messages to avoid having to hit a key
                                    
  set scrolloff=4                   " keep lines around cursor
" set sidescrolloff=2               " keep columns around cursor

  set titlestring=%t                " show filename as window title
  set showcmd                       " display incomplete commands
  set nomodeline                    " disable vim mode lines
  set wildmenu                      " enable command line completion enhanced mode
  set wildmode=list:longest         " use large list for command line completion
  set cursorline                    " highlight current line for visability

  set tags=tags,build/tags         " set tags file location 

  " ignore file extensions in command line completion
  set wildignore+=*.o,*.lo,*.obj,*.exe,*.pyc,*.pyo
  set wildignore+=*.bak,*.jpg,*.gif,*.png
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

  " show status line
  set laststatus=2
  set statusline=%t%m%r%h%w\ [%{&ff}\ %Y]\ [%l/%L\ (%p%%)]\ [col=%c\ val=0x%B]

" }}}


" EDITING
" {{{
  syntax on                         " syntax highlighting

  set history=1000                  " remember more commands and search history
  set undolevels=1000               " use many levels of undo

  set number                        " show line numbers
  set numberwidth=4                 " line numbering width
  set nowrap                        " disable line wrap
  set showmode                      " always show current mode
  set showmatch                     " show matching braces
  set backspace=indent,eol,start    " allow backspacing over everything in insert mode
" set nostartofline                 " prevent jump to first character when paging

  set expandtab                     " expand tabs into spaces
  set smarttab                      " insert tabs on start of a line according to
                                    "   shiftwitdth, not tabstop
  set tabstop=4                     " numbers of spaces of tab character
  set shiftwidth=4                  " numbers of spaces to (auto)indent
  set softtabstop=4                 " when hitting <BS> pretend like a tab is removed if spaces
  set shiftround                    " round indent to multiple of shiftwidth
  set autoindent                    " always autoindent
  set copyindent                    " copy previous indentation on auto indent

  set incsearch                     " show search matches while typing
  set hlsearch                      " highlight search
" set ignorecase                    " search ignores case
  set smartcase                     " search case-sensitive if search contains caps

  filetype plugin on                " load filetype and indent plugins
  filetype plugin indent on         " load filetype and indent plugins
" }}}

" FOLDING
" {{{
  set foldenable                    " enable folding
  set foldmethod=marker             " fold using markers
  set foldlevel=100                 " no folding by default

  " commands that trigger auto-unfold
  set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
" }}}

" OMNICOMPLETE
" {{{
  
  " complete with longest matching text, always show menu
  set completeopt=menu,longest

" }}}

" AUTOCOMMANDS
" {{{

  " C/C++
  autocmd FileType c,cpp set comments=s:/*,mb:*,ex:*/     " commenting
  "autocmd FileType c,cpp VimEnter * TagbarOpen

  " Python
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  "autocmd FileType python VimEnter * TagbarOpen

" }}}

" PLUGINS
" {{{

  " NERD Tree
  let NERDTreeChDirMode = 0                 " never change directory
  let NERDTreeStatusline=" "                " override status line
  let NERDTreeQuitOnOpen = 0                " close after opening file
  let NERDTreeIgnore = ['\.bak$', '\.swp$'] " ignore backup and swap files
  let NERDTreeSortOrder = ['\/$', '*']      " sort files then directories
  let NERDTreeWinSize = 24                  " set windows size
  "autocmd VimEnter * NERDTree               " automatically open NERDTree
  "autocmd BufEnter * NERDTreeMirror         " mirror NERDTree between tabs
  "autocmd VimEnter * wincmd w               " move cursor to file being edited
  
  " Tag Bar
  let g:tagbar_width = 24                   " set tagbar width
  let g:tarbar_expand = 0                   " expand window when opening tagbar
  "autocmd BufRead * TagbarOpen
  
  " UltiSnip
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]
  
  " CtrlP
  let g:ctrlp_working_path_mode = 0         " do not manage working directory

  " Supertab
  "let g:SuperTabDefaultCompletionType = "context"
  "let g:SuperTabContextDefaultCompletionType="<c-x><c-o>"

  " Syntastic
  let g:syntastic_enable_highlighting = 0   " disable highlighting
  let g:syntastic_check_on_open = 1         " check buffers on open
  let g:syntastic_c_include_dirs = [ 'src', 'src/include' ]
  let g:syntastic_c_compiler_options = '-std=gnu99'
  
" }}}

" MAPPINGS
" {{{
  " set paste toggle
  set pastetoggle=<F3>

  " edit and update vimrc
  nmap <leader>ev :e $MYVIMRC<CR>     
  nmap <leader>sv :source $MYVIMRC<CR> 

  " replace tabs with spaces
  nmap <leader>ft <ESC>:%s/	/    /g<CR> 

  " open plugin windows
  nmap <F1> :NERDTreeToggle<CR> 
  nmap <F2> :TagbarToggle<CR>

  " clear search highlights
  nmap <leader>h :noh<CR>

  " make
  nmap <leader>m :make! -C build<CR>
  nmap <leader>d :make! -C build ctags cscope<CR>

  " viewport control (left, down, up, right)
  nmap <leader>h <C-w>h
  nmap <leader>j <C-w>j
  nmap <leader>k <C-w>k
  nmap <leader>l <C-w>l

  " follow tags
  nmap <C-Left> <C-T>
  nmap <C-Right> <C-]>

  nmap <C-Tab> :bn<CR>

" }}}

" GUI  
" {{{
  if has("gui_running")
    
    "colorscheme wombat
    "highlight SignColumn guifg=#808080 guibg=#303030 gui=none

    set guitablabel=%t\ %m%r            " tab label
    "set guifont=Liberation\ Mono\ 9     " font
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 11     " font
    set guioptions-=m                   " remove toolbar
    set guioptions-=l                   " simple dialogs, no popups
    set guioptions-=L                   " simple dialogs, no popups
    set guioptions-=r                   " simple dialogs, no popups
    set guioptions-=R                   " simple dialogs, no popups
    set title                           " show window title
  
    " switch fonts in gui mode
    map <F10>  <ESC>:set guifont=Liberation\ Mono\ 9<CR>
    map <F11> <ESC>:set guifont=Liberation\ Mono\ 12<CR>
    map <F12> <ESC>:set guifont=Liberation\ Mono\ 16<CR>

  else
    set background=dark

  endif
" }}}