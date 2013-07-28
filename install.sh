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
  link "bash/bashrc"              ".bashrc"
  link "bash/bash_profile"        ".bash_profile"
  link "bash/lib"                 ".bash_profile.d"
  link "ssh/config"               ".ssh/config"
  link "vim/vimrc"                ".vimrc"
  copy "vim/gvimrc"               ".gvimrc"
  link "vim/bundles.vim"          ".vim/bundles.vim"
  link "vim/plugin/custom"        ".vim/plugin/custom"
  link "vim/colors/molokai.vim"   ".vim/colors/molokai.vim"
  link "zsh/oh-my-zsh"            ".oh-my-zsh"
  link "zsh/zshrc"                ".zshrc"
  link "zsh/custom.zsh-theme"     ".oh-my-zsh/custom/custom.zsh-theme"
  link "custom/example.sh"        ".custom/example.sh"
  ecmd "git/config.sh"

  # Install (Linux)
  if [[ "$OSTYPE" == linux* ]]; then
  link "fonts/powerline-fonts" ".fonts/powerline-fonts"
  fi

  # Install (OSX)
  if [[ "$OSTYPE" == darwin* ]]; then
  link "fonts/powerline-fonts" "Library/Fonts/Powerline-Fonts"
  fi
}

#-----------------------------------------------------------------------------
# Support Functions
#-----------------------------------------------------------------------------

# logging
function log_list_check() { printf "  \033[1;32m✔\033[0m $1\n"; }
function log_list_error() { printf "  \033[1;31m✖\033[0m $1\n"; }

# backup file to backup directory
# 1: target file or directory to move into backup directory
function backup() {
  mkdir -p "$BACKUPDIR"
  mv "$1" "$BACKUPDIR"
  if [[ "$?" -eq 0 ]]; then
    log_list_check "(Backup) $1 to $BACKUPDIR"
  else
    log_list_error "(Backup) $1"
  fi
}

# link file from the repository to home directory
# creates a backup of existing file if it exists
# 1: source file or directory in repository ($REPODIR)
# 2: target link in user home directory ($HOME)
function link() {
  SRC="$REPODIR/$1"
  DEST="$HOME/$2"
  if [[ -e "$DEST" && ! -L "$DEST" ]]; then
    backup "$DEST"
  elif [[ -L "$DEST" ]]; then
    unlink "$DEST"
  fi
  mkdir -p $( dirname "$DEST" )
  ln -s "$SRC" "$DEST"
  if [[ "$?" -eq 0 ]]; then
    log_list_check "(Link)   $DEST"
  else
    log_list_error "(Link)   $DEST"
  fi
}

# copy file from the repository to user home directory
# does not overwrite file if it already exists
# 1: source file or directory in repository ($REPODIR)
# 2: target link in user home directory ($HOME)
function copy() {
  SRC="$REPODIR/$1"
  DEST="$HOME/$2"
  if [[ ! -e "$DEST" || -L "$DEST" ]]; then
    rm "$DEST"
    cp -a "$SRC" "$DEST"
    if [[ "$?" -eq 0 ]]; then
      log_list_check "(Copy)   $DEST"
    else
      log_list_error "(Copy)   $DEST"
    fi
  fi
}

# executes a command from the repository
# 1: command to run in the repository ($REPODIR)
function ecmd() {
  CMD="$REPODIR/$1"
  "$CMD"
  if [[ "$?" -eq 0 ]]; then
    log_list_check "(Exec)   $1"
  else
    log_list_error "(Exec)   $1"
  fi
}

#-----------------------------------------------------------------------------
# Main
#-----------------------------------------------------------------------------
if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP
Usage: $(basename "$0") - https://github.com/eschwabe/dotfiles

Installs dotfiles from this repository into the current user's home directory.
HELP
exit; 
fi

# Test if git is in path
if [[ ! "$(type -p git)" ]]; then
  log_error "Git required to setup"
  exit
fi

# Initialize
pushd "$REPODIR" >/dev/null

# Run Install
run

# Cleanup
popd >/dev/null
