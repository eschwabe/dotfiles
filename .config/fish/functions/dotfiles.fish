function dotfiles --wraps='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' --description 'alias dotfiles git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
        
end
