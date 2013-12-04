# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(cp git vundle)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Load theme
source $HOME/.zsh/simple.zsh-theme

# Load vi-mode
source $HOME/.profile.d/vi-mode.zsh

# Load any custom shell configuration
for config_file ($HOME/.profile.d/*.sh); do
  source $config_file
done
