function fish_greeting
end

if status is-interactive
    fish_vi_key_bindings

    if test -f ~/.config/fish/colors.fish
        source ~/.config/fish/colors.fish
    end

    zoxide init fish | source
end

starship init fish | source
tv init fish | source 
atuin init fish | source
hermes completion fish | source

