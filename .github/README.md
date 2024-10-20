# Dotfiles

## Overview
Personal dotfile configurations for MacOS and Linux. The repository is setup to be installed in your $HOME directory. The dotfiles
include configuration for zsh, vim, fonts, git, and other tools. The dotfiles are installed and managed with git.

## Installation
Dotfiles are installed using git commands. See this tutorial for details https://www.atlassian.com/git/tutorials/dotfiles.

```bash
git clone --bare https://github.com/eschwabe/dotfiles.git $HOME/.dotfiles

alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

dotfiles checkout
```

## Customization
Additional shell (bash or zsh) files may be added to the ~/.profile.d directory. Anyfiles will be automatically sourced.

Executable scripts amy be added to `$HOME/.local/bin`.

## References
* https://github.com/andsens/homeshick
* https://github.com/robbyrussell/oh-my-zsh
* https://github.com/revans/bash-it
* https://github.com/mathiasbynens/dotfiles
* https://github.com/skwp/dotfiles
* https://github.com/r00k/dotfiles
* https://github.com/gf3/dotfiles?tab=readme-ov-file
