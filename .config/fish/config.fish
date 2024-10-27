if status is-interactive
    # Commands to run in interactive sessions can go here
    if type -q starship
        starship init fish | source
    end
    if type -q pyenv
        pyenv init - | source
    end
    if test -r $HOME/.config/fish/config.local.fish
        source $HOME/.config/fish/config.local.fish
    end

    test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
    test -d /opt/homebrew/bin; and fish_add_path /opt/homebrew/bin
end
