# Common shell configuration (bash and zsh)

# Display path
function path(){
    echo $PATH | tr ':' '\n'
}

# Append to path variable
pathmunge () {
  if ! echo $PATH | egrep -q "(^|:)$1($|:)" ; then
    if [ "$2" = "after" ] ; then
      PATH="$PATH:$1"
    else
      PATH="$1:$PATH"
    fi
  fi
}

# Customize path
PATH="/usr/bin"
pathmunge /usr/local/bin
pathmunge /bin
pathmunge /usr/bin
pathmunge /usr/sbin
pathmunge /sbin
pathmunge /usr/X11/bin
pathmunge /opt/local/bin
pathmunge /opt/local/sbin

# Set default editor
export EDITOR="vim"
export VISUAL="$EDITOR"

# Source homeshick
source $HOME/.homesick/repos/homeshick/homeshick.sh

# Setup pager
export PAGER="less"
export LESS="-x4RFsX"

# Pager source highlighting
if [ -f "/usr/share/source-highlight/src-hilite-lesspipe.sh" ]; then
    # ubuntu 12.10: sudo apt-get install source-highlight
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
elif [ -f "/usr/bin/src-hilite-lesspipe.sh" ]; then
    # fedora 18: sudo yum install source-highlight
    export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
fi
