# GIT CONF
# Update git configuration with default settings

# decorate logs
git config --global log.decorate short

# colorize output (Git 1.5.5 or later)
git config --global color.ui auto

# and from 1.5.4 onwards, this will works:
git config --global color.interactive auto

# user-friendly paging of some commands which don't use the pager by default
# (other commands like "git log" already do)
# to override pass --no-pager or GIT_PAGER=cat
git config --global pager.status false
git config --global pager.show-branch true

# shortcut aliases
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout

# another feature that will be available in 1.5.4 onwards
# this is useful when you use topic branches for grouping together logically related changes
git config --global format.numbered auto

# turn on new 1.5 features which break backwards compatibility
git config --global core.legacyheaders false
git config --global repack.usedeltabaseoffset true

# default to pushing current branch to remote if no refspec specified
# remote branch with the same name must exist
git config --global push.default simple
