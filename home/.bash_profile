# Bash shell configuration

# Load the shell configuration in ~/.bash_profile.d
LIB="${HOME}/.bash_profile.d/*.bash"
for file in $LIB; do
  [ -r "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null
done

# Load custom shell configurations in ~/.profile.d
CUSTOM="${HOME}/.profile.d/*.sh"
for file in $CUSTOM; do
  [ -r "$file" ] && source "$file"
done
unset file
