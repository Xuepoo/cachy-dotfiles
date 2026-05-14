function fish_greeting
end

if status is-interactive
    fish_vi_key_bindings

    zoxide init fish | source
end

starship init fish | source
tv init fish | source 
atuin init fish | source
