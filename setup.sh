#!/bin/sh
# vim: set tabstop=2 shiftwidth=2

#-----------------------------------------------------------------------------
# Variables
#-----------------------------------------------------------------------------
BACKUPDIR="$HOME/.dotfiles-backup/$(date "+%Y%m%d%H%M.%S")"
REPODIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#-----------------------------------------------------------------------------
# Run Function
#-----------------------------------------------------------------------------
function run() {
  install "vim/bundle/vundle"   ".vim/bundle/vundle"
  install "vim/vimrc"           ".vimrc"
  install "zsh/oh-my-zsh"       ".oh-my-zsh"
  install "zsh/zshrc"           ".zshrc"

  # Install (Linux)
  if [[ "$OSTYPE" == linux* ]]; then
  install "fonts/powerline-fonts" ".fonts/powerline-fonts"
  fi

  # Install (OSX)
  if [[ "$OSTYPE" == darwin* ]]; then
  install "fonts/powerline-fonts" "Library/Fonts/Powerline-Fonts"
  fi
}

#-----------------------------------------------------------------------------
# Support Functions
#-----------------------------------------------------------------------------

# logging
function log_notice()     { echo "\033[1;32m➜ $1\033[0m"; }
function log_error()      { echo "\033[1;31mError: $1\033[0m"; }
function log_list_check() { echo "  \033[1;32m✔\033[0m $1"; }
function log_list_error() { echo "  \033[1;31m✖\033[0m $1"; }

# backup file to backup directory
# 1: target file or directory to move into backup directory
function backup() {
  mkdir -p "$BACKUPDIR"
  mv "$1" "$BACKUPDIR"
  if [[ "$?" -eq 0 ]]; then
    log_list_check "(Backup)  $1 to $BACKUPDIR"
  else
    log_list_error "(Backup)  $1"
  fi
}

# link file from the repository to home directory
# 1: source file or directory in repository
# 2: target link in user home directory
function link() {
  mkdir -p $( dirname "$2" )
  ln -s "$1" "$2"
  if [[ "$?" -eq 0 ]]; then
    log_list_check "(Install) $2"
  else
    log_list_error "(Install) $2"
  fi
}

# install file from the repository to user home directory
# 1: source file or directory in repository ($REPODIR)
# 2: target link in user home directory ($HOME)
function install() {
  SRC="$REPODIR/$1"
  DEST="$HOME/$2"
  if [[ -e "$DEST" && ! -L "$DEST" ]]; then
    backup "$DEST"
  elif [[ -L "$DEST" ]]; then
    unlink "$DEST"
  fi
  link "$SRC" "$DEST"
}

#-----------------------------------------------------------------------------
# Main
#-----------------------------------------------------------------------------
if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP
Usage: $(basename "$0") - https://github.com/eschwabe/dotfiles

Updates and installs dotfiles from this repository. The dotfiles are linked
to the current user's home directory. See the README for documentation.
HELP
exit; 
fi

# Test if git is in path
if [[ ! "$(type -p git)" ]]; then
  log_error "Git required to setup"
  exit
fi

# Initialize
log_notice 'DOTFILES - Eric Schwabe'
pushd "$REPODIR" >/dev/null

# Update Repos
log_notice "Updating"
git pull origin master
git submodule init
git submodule update

# Run Install
log_notice "Installing"
run

# Cleanup
popd >/dev/null
log_notice "Done"

