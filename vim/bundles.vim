" Loads plugins using vundle

filetype off

set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'

if has("python") || has("python3")
    Bundle 'Lokaltog/powerline', { 'rtp': 'powerline/bindings/vim/' }
    Bundle 'SirVer/ultisnips'
    Bundle 'Valloric/YouCompleteMe'
endif

filetype plugin indent on

