" Loads plugins using vundle

filetype off

if filereadable(expand("$HOME/.vim/bundle/Vundle.vim"))

  set runtimepath+=~/.vim/bundle/Vundle.vim
  call vundle#rc()

  Plugin 'Raimondi/delimitMate'
  Plugin 'bling/vim-airline'
  Plugin 'gmarik/vundle'
  Plugin 'kien/ctrlp.vim'
  Plugin 'majutsushi/tagbar'
  Plugin 'mattn/emmet-vim'
  Plugin 'scrooloose/nerdtree'
  Plugin 'tpope/vim-commentary'
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-repeat'
  Plugin 'tpope/vim-sensible'
  Plugin 'tpope/vim-surround'

  Plugin 'chriskempson/tomorrow-theme', { 'rtp': 'vim/' }

  if version >= 703
    if has("python") || has("python3")
      Plugin 'SirVer/ultisnips'
      Plugin 'Valloric/YouCompleteMe'
      Plugin 'honza/vim-snippets'
      Plugin 'scrooloose/syntastic'
    endif
  endif

  filetype plugin indent on

endif
