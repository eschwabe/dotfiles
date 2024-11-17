# Load shell configuration files
if [ "$(ls -A $HOME/.config/zsh/)" ]; then
  for config_file ($HOME/.config/zsh/*); do
    #echo "Loading ${config_file}"
    source "${config_file}"
  done
fi
