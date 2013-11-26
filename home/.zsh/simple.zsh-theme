# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background and the font Inconsolata.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# Based on http://blog.ysmood.org/2013/03/my-ys-terminal-theme/

# Git Info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[black]%}on%{$reset_color%} %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓"

PROMPT="\
%{$terminfo[bold]$fg[white]%}[%{$reset_color%} \
%{$fg[black]%}%* \
%{$fg[cyan]%}%n \
%{$fg[black]%}at \
%{$fg[green]%}%m \
%{$fg[black]%}in \
%{$terminfo[bold]$fg[red]%}%~%{$reset_color%}\
${git_info}%{$fg[white]%} ]
%{$terminfo[bold]$fg[black]%}》%{$reset_color%}"

