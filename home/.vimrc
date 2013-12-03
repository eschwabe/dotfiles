" VIM CONFIGURATION 
"
" Maintained by Eric Schwabe
"
" To start vim without using this .vimrc file, use:
" vim -u NORC
" To start vim without loading any .vimrc or plugins, use:
" vim -u NONE

" Use vim settings rather than vi
" Must be first since it affects other options
set nocompatible

" Change mapleader from \ to ,
let mapleader=","

" ----------------------------------------------------------------------------
" VUNDLE INITIALIZATION
" ----------------------------------------------------------------------------
if filereadable(expand("$HOME/.vim/bundles.vim"))
    source ~/.vim/bundles.vim
endif

" ----------------------------------------------------------------------------
" GENERAL
" ----------------------------------------------------------------------------
set noshowmode                  " Hide mode in command line
set encoding=utf-8              " Set encoding to UTF-8
set t_Co=256                    " Explicitly tell Vim that the terminal supports 256 colors
set autowriteall                " Auto write buffers
set autoread                    " Auto reload files changed outside vim
set noexrc                      " Do not use local directory config (.vimrc)
set visualbell                  " Turn off visual bell
set noerrorbells                " Disable beep and screen flashes
set hidden                      " Hide buffers instead of closing them
set nobackup                    " Disable backup files
set noswapfile                  " Disable swap files
set history=1000                " Store lots of command history
set cursorline                  " Highlight current line for visability
set scrolloff=10                " Keep lines around cursor
set laststatus=2                " Always show status line

" Default status line
set statusline=%t%m%r%h%w\ [%{&ff}\ %Y]\ [%l/%L\ (%p%%)]\ [col=%c\ val=0x%B]

" Set default tags file locations
set tags+=tags,build/tags

" Set default colorscheme
try
    colorscheme Tomorrow-Night
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme molokai
endtry

" ----------------------------------------------------------------------------
" UNDO
" ----------------------------------------------------------------------------
if !isdirectory(expand("$HOME/.vim/backups"))
    call mkdir(expand("$HOME/.vim/backups"))
endif

if version >= 703
  set undodir=~/.vim/backups
  set undofile
endif

" ----------------------------------------------------------------------------
" EDITING
" ----------------------------------------------------------------------------
set number                      " Show line numbers
set numberwidth=4               " Line numbering width
set nowrap                      " Disable line wrap
set showmatch                   " Show matching braces
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode
set expandtab                   " Expand tabs into spaces
set smarttab                    " Insert tabs on start of a line according to shiftwitdth, not tabstop
set tabstop=4                   " Numbers of spaces of tab character
set shiftwidth=4                " Numbers of spaces to (auto)indent
set softtabstop=4               " When hitting <BS> pretend like a tab is removed if spaces
set shiftround                  " Round indent to multiple of shiftwidth
set autoindent                  " Always autoindent
set copyindent                  " Copy previous indentation on auto indent

syntax on                       " Syntax highlighting
filetype plugin indent on       " Load filetype and indent plugins

" Display tabs and trailing spaces
set list listchars=tab:\ \ ,trail:·

" ----------------------------------------------------------------------------
" FOLDING
" ----------------------------------------------------------------------------
if has("folding")
  set foldenable                " Enable folding
  set foldmethod=marker         " Fold using markers
  set foldlevel=100             " No folding by default

  " Commands that trigger auto-unfold
  set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
endif

" ----------------------------------------------------------------------------
" COMPLETION
" ----------------------------------------------------------------------------
set wildmenu                    " Enable command line completion enhanced mode
set wildmode=list:longest       " Use large list for command line completion
set completeopt=menu,longest    " Complete with longest match, show menu

set wildignore+=*.o,*.lo,*.obj,*.exe,*.pyc,*.pyo
set wildignore+=*.bak,*.jpg,*.gif,*.png
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

