source /usr/share/cachyos-fish-config/cachyos-config.fish

if status is-interactive
    set -g fish_greeting ""
    fish_vi_key_bindings

    zoxide init fish | source
end

starship init fish | source
tv init fish | source 
atuin init fish | source
    
# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
