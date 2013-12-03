" Loads plugins using vundle

filetype off

set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'bling/vim-airline'
Bundle 'chriskempson/tomorrow-theme', { 'rtp': 'vim/' }

if version >= 703
  if has("python") || has("python3")
    Bundle 'scrooloose/syntastic'
    Bundle 'SirVer/ultisnips'
  endif
  if has("lua")
    Bundle 'Shougo/neocomplete.vim'
  endif
endif

filetype plugin indent on


