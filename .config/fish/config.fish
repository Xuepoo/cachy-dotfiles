function fish_greeting
end

if status is-interactive
    fish_vi_key_bindings

    if test -f ~/.config/fish/colors.fish
        source ~/.config/fish/colors.fish
    end

    function _reload_colors --on-variable theme_mode
        if test -f ~/.config/fish/colors.fish
            source ~/.config/fish/colors.fish
        end
    end

    zoxide init fish | source
end

starship init fish | source
tv init fish | source 
atuin init fish | source
hermes completion fish | source



# Added by Antigravity CLI installer
set -gx PATH "/home/fuyu/.local/bin" $PATH

# >>> grok installer >>>
fish_add_path $HOME/.grok/bin
# <<< grok installer <<<
