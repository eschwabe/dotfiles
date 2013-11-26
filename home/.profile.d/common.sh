# Common shell configuration (bash and zsh)

# Display path
function path(){
    echo $PATH | tr ':' '\n'
}

# Append to path variable
pathmunge () {
  if ! echo $PATH | egrep -q "(^|:)$1($|:)" ; then
    if [ "$2" = "after" ] ; then
      PATH=$PATH:$1
    else
      PATH=$1:$PATH
    fi
  fi
}

# Customize path
pathmunge /opt/local/bin
pathmunge /opt/local/sbin
pathmunge /usr/local/bin
pathmunge /usr/bin
pathmunge /bin
pathmunge /usr/sbin
pathmunge /sbin
pathmunge /usr/X11/bin

# Set default editor
export EDITOR="vim"
export VISUAL="$EDITOR"

# Source homeshick
source $HOME/.homesick/repos/homeshick/homeshick.sh
