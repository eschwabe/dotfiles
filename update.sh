#!/bin/sh
# vim: set tabstop=2 shiftwidth=2

#-----------------------------------------------------------------------------
# Variables
#-----------------------------------------------------------------------------
REPODIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#-----------------------------------------------------------------------------
# Support Functions
#-----------------------------------------------------------------------------

# logging
function log_notice()     { printf "\033[1;32m➜ $1\033[0m\n"; }
function log_error()      { printf "\033[1;31mError: $1\033[0m\n"; }

#-----------------------------------------------------------------------------
# Main
#-----------------------------------------------------------------------------
if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP
Usage: $(basename "$0") - https://github.com/eschwabe/dotfiles

Update this dotfiles repository and all submodules. The dotfiles setup
script is run afterwards. See the README for documentation.
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
./install.sh

# Cleanup
popd >/dev/null
log_notice "Done"

