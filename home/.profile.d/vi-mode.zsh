# Set vi keybindings
bindkey -v

# Configure cursor color based on mode
INSERT_PROMPT="gray"
COMMAND_PROMPT="green"

# Helper for setting color including all kinds of terminals
set_prompt_color() {
  if [[ "$1" == "green" ]]; then
    if [[ -n "$ITERM_SESSION_ID" ]]; then
      echo -ne "\033]Pl2BFC47\033\\"
    else
      echo -ne "\033]12;green\007"
    fi
  elif [[ "$1" == "gray" ]]; then
    if [[ -n "$ITERM_SESSION_ID" ]]; then
      echo -ne "\033]PlDBFFE0\033\\"
    else
      echo -ne "\033]12;gray\007"
    fi
  fi
}

# Change cursor color basing on vi mode
zle-keymap-select () {
    if [ $KEYMAP = vicmd ]; then
        set_prompt_color $COMMAND_PROMPT
    else
        set_prompt_color $INSERT_PROMPT
    fi
}

zle-line-finish() {
    set_prompt_color $INSERT_PROMPT
}

zle-line-init () {
    zle -K viins
    set_prompt_color $INSERT_PROMPT
}

zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish
