" VIM CONFIGURATION
"
" Maintained by Eric Schwabe
"
" To start vim without using this .vimrc file, use:
" vim -u NORC
" To start vim without loading any .vimrc or plugins, use:
" vim -u NONE

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
set noshowmode          " Hide mode in command line
set t_Co=256            " Explicitly state the terminal supports 256 colors
set autowriteall        " Auto write buffers
set autoread            " Auto reload files changed outside vim
set noexrc              " Do not use local directory config (.vimrc)
set visualbell          " Turn off visual bell
set noerrorbells        " Disable beep and screen flashes
set hidden              " Hide buffers instead of closing them
set nobackup            " Disable backup files
set noswapfile          " Disable swap files
set history=1000        " Store lots of command history
set cursorline          " Highlight current line for visability

" Highlight text past column 81
match CursorLine /\%81v.\+/

" Set default status line
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
set expandtab                   " Expand tabs into spaces
set tabstop=4                   " Numbers of spaces of tab character
set shiftwidth=4                " Numbers of spaces to (auto)indent
set softtabstop=4               " When hitting <BS> remove spaces as if tab
set copyindent                  " Copy previous indentation on auto indent
set list                        " Display tabs and trailing spaces

set listchars=trail:·,precedes:«,extends:»,tab:▸\

" ----------------------------------------------------------------------------
" COMMAND-LINE COMPLETION
" ----------------------------------------------------------------------------
set wildmenu                    " Enable command line completion enhanced mode
set wildmode=full               " Complete the next full match

set wildignore+=*.o,*.lo,*.obj,*.exe,*.pyc,*.pyo
set wildignore+=*.bak,*.jpg,*.gif,*.png
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

" ----------------------------------------------------------------------------
" ADDITIONAL SETTINGS
" ----------------------------------------------------------------------------
source ~/.vim/settings.vim
