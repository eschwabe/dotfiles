#!/bin/sh

#-----------------------------------------------------------------------------
# Variables
#-----------------------------------------------------------------------------
backupdir="$HOME/.dotfiles-backup/$(date "+%Y%m%d%H%M.%S")"
excluded=(. .. .git .gitignore setup.sh README)
included=()

#-----------------------------------------------------------------------------
# Functions
#-----------------------------------------------------------------------------

# logging
# $1 - message
function log_notice()     { echo "\033[1;32m➜ $1\033[0m"; }
function log_error()      { echo "\033[1;31mError: $1\033[0m"; }
function log_list_check() { echo "  \033[1;32m✔\033[0m $1"; }
function log_list_error() { echo "  \033[1;31m✖\033[0m $1"; }

# create array of files to manipulate
# sets the filelist global variable
function initialize() {
  local files=( $(ls -a) )
  index=0
  for file in "${files[@]}"; do
    for exclude in "${excluded[@]}"; do
      if [[ "$exclude" == "$file" ]]; then
        unset files[$index]
      fi
    done
    index=$index+1
  done
  filelist=("${files[@]}" "${included[@]}")
  return 0
}

# backup home directory contents
function backup() {
  mkdir -p $backupdir
  for file in "${filelist[@]}"; do
    if [[ -e "$HOME/$file" && ! -L "$HOME/$file" ]]; then
      cp -a -f "$HOME/$file" "$backupdir/$file"
      if [[ "$?" -eq 0 ]]; then
        log_list_check "$HOME/$file"
      else
        log_list_error "$HOME/$file"
      fi
    fi
  done
}

# link source directory contents to home directory
function install() {
  sourcedir="`pwd`"
  for file in "${filelist[@]}"; do
    ln -s -f "$sourcedir/$file" "$HOME/$file"
    if [[ "$?" -eq 0 ]]; then
      log_list_check "$file"
    else
      log_list_error "$file"
    fi
  done
}

# remove links in home directory
function remove() {
  for file in "${filelist[@]}"; do
    unlink "$HOME/$file"
    if [[ "$?" -eq 0 ]]; then
      log_list_check "$file"
    else
      log_list_error "$file"
    fi
  done 
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

filelist=()
initialize

#-----------------------------------------------------------------------------
# Commands
#-----------------------------------------------------------------------------
if [[ -z "$1" || "$1" == "install" ]]; then

  if [[ ! "$(type -p git)" ]]; then
    log_error "Git required to install"
    exit
  fi

  if [ -d $HOME/.dotfiles ]; then
    # Update Repos
    pushd $HOME/.dotfiles >/dev/null
    log_notice "Updating"
    git pull origin master
    git submodule init
    git submodule update
  else
    # Clone Repos
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
  log_notice "Removing"
  pushd $HOME/.dotfiles >/dev/null
  remove

  # Cleanup
  popd >/dev/null
  log_notice "Done"

else
  log_error "Unknown Command ($1)"
  exit

fi

