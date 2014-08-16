" Loads plugins using vundle

filetype off

set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'bling/vim-airline'
Bundle 'gmarik/vundle'
Bundle 'Raimondi/delimitMate'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/emmet-vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'

Bundle 'chriskempson/tomorrow-theme', { 'rtp': 'vim/' }

if version >= 703
  if has("python") || has("python3")
    Bundle 'scrooloose/syntastic'
  endif
  if has("lua")
    Bundle 'Shougo/neocomplete'
    Bundle 'Shougo/neosnippet'
    Bundle 'honza/vim-snippets'
  endif
endif

filetype plugin indent on
