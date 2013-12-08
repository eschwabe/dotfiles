# Common shell functions

# Copy w/ progress
cpprogress () {
  rsync -WavP --human-readable --progress $1 $2
}
