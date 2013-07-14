#!/bin/sh

#-----------------------------------------------------------------------------
# Variables
#-----------------------------------------------------------------------------
backupdir="$HOME/.dotfiles-backup/$(date "+%Y%m%d%H%M.%S")"
excluded=(. .. .git .gitignore setup.sh README)

#-----------------------------------------------------------------------------
# Functions
#-----------------------------------------------------------------------------

# logging
# $1 - message
function log_notice()     { echo "\033[1;32m➜ $1\033[0m"; }
function log_error()      { echo "\033[1;31mError: $1\033[0m"; }
function log_list_check() { echo "  \033[1;32m✔\033[0m $1"; }
function log_list_error() { echo "  \033[1;31m✖\033[0m $1"; }

# backup home directory contents
function backup() {
  mkdir -p $backupdir
  local files=( $(ls -a) )
  for file in "${files[@]}"; do
    in_array $file "${excluded[@]}"
    if [[ "$?" -eq 1 && -e "$HOME/$file" && ! -L "$HOME/$file" ]]; then
      mv -f "$HOME/$file" "$backupdir/$file" && log_list_check "$HOME/$file"
    fi
  done
}

# link source directory contents to home directory
function install() {
  local files=( $(ls -a) )
  for file in "${files[@]}"; do
    in_array $file "${excluded[@]}"
    should_install=$?
    if [ $should_install -gt 0 ]; then
      ln -s -f "`pwd`/$file" "$HOME/$file"
      if [[ "$?" -eq 0 ]]; then
        log_list_check "$file"
      else
        log_list_error "$file"
      fi
    fi
  done
}

# remove links in home directory
function remove() {
  echo "Remove files here"
}

# configure system to use dotfiles
function configure() {
  echo "Configure files here"
  #
  # vundle setup
  # sublime text
  # oh-my-zsh
  # oh-my-zsh-powerline theme
  # bash-it
  # change default shell to zsh?
  # fonts
  #
}

# test if item in an array
function in_array() {
  local hay needle=$1
  shift
  for hay; do
    [[ $hay == $needle ]] && return 0
  done
  return 1
}

#-----------------------------------------------------------------------------
# Main
#-----------------------------------------------------------------------------
if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP
Usage: $(basename "$0") [install|remove]
  install - Update dotfiles and link to home directory
  remove  - Remove all links in home directory

See the README for documentation.
https://github.com/eschwabe/dotfiles
HELP
exit; fi

log_notice 'DOTFILES - Eric Schwabe'

#-----------------------------------------------------------------------------
# Commands
#-----------------------------------------------------------------------------
if [[ -z "$1" || "$1" == "install" ]]; then

  if [[ ! "$(type -p git)" ]]; then
    log_error "Git required to install"
    exit
  fi

  if [ -d $HOME/.dotfiles ]; then
    # Update Repo
    pushd $HOME/.dotfiles >/dev/null
    log_notice "Updating"
    git pull origin master
    git submodule init
    git submodule update
  else
    # Clone Repo
    log_notice "Downloading"
    git clone --recursive https://github.com/eschwabe/dotfiles.git $HOME/.dotfiles
    pushd $HOME/.dotfiles >/dev/null
  fi

  # Backup
  log_notice "Backup up old files ($backupdir)"
  backup

  # Install
  log_notice "Installing"
  install

  # Setup
  log_notice "Setting Up"
  configure

  # Cleanup
  popd >/dev/null
  log_notice "Done"

elif [[ "$1" == "remove" ]]; then
  # Remove links
  echo "Removing"
  pushd $HOME/.dotfiles >/dev/null
  remove

  # Cleanup
  popd >/dev/null
  log_notice "Done"

else
  log_error "Unknown Command ($1)"
  exit

fi

