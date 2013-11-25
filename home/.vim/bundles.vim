" Loads plugins using vundle

filetype off

set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'thinca/vim-fontzoom'
Bundle 'kien/ctrlp.vim'

if version >= 703
  if has("python") || has("python3")
    Bundle 'scrooloose/syntastic'
    Bundle 'Lokaltog/powerline', { 'rtp': 'powerline/bindings/vim/' }
    Bundle 'SirVer/ultisnips'
    Bundle 'Valloric/YouCompleteMe'
  endif
endif

filetype plugin indent on

