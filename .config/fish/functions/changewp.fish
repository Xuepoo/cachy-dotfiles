function changewp --description "Change wallpaper and dynamically regenerate colors using Awww and Matugen"
    set -l wp_dir "$HOME/Pictures/Wallpapers"
    
    if test (count $argv) -eq 0
        if type -q television
            set -l selected (find $wp_dir -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | television)
            if test -n "$selected"
                set argv $selected
            else
                return 0
            end
        else if type -q fzf
            set -l selected (find $wp_dir -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | fzf)
            if test -n "$selected"
                set argv $selected
            else
                return 0
            end
        else
            echo "Usage: changewp <wallpaper_path_or_filename>"
            echo "Available wallpapers in $wp_dir:"
            ls -1 $wp_dir
            return 1
        end
    end

    set -l wp_path $argv[1]

    # If the user passed just a filename, resolve it to the full path
    if not test -f "$wp_path"; and test -f "$wp_dir/$wp_path"
        set wp_path "$wp_dir/$wp_path"
    end

    if not test -f "$wp_path"
        echo "Error: File '$wp_path' not found."
        return 1
    end

    echo "Changing wallpaper to: $wp_path"
    
    # 1. Set wallpaper using Awww
    /usr/bin/awww img "$wp_path"
    
    # 2. Generate theme using Matugen (dual-config split)
    if not set -q theme_mode
        set -U theme_mode dark
    end
    set -U current_wallpaper "$wp_path"

    # 2a. Desktop components (Waybar, Hyprland, SwayNC, GTK) follow system theme_mode
    /home/fuyu/.local/share/cargo/bin/matugen --config ~/.config/matugen/config.toml --contrast 0.15 -t scheme-vibrant -m $theme_mode image --source-color-index 0 "$wp_path"

    # 2b. Terminal/TUI components (Ghostty, Fish, Starship, btop, cava...) always dark for legibility
    /home/fuyu/.local/share/cargo/bin/matugen --config ~/.config/matugen/config-terminal.toml --contrast 0.15 -t scheme-vibrant -m dark image --source-color-index 0 "$wp_path"

    # 2c. Apply correct Ghostty opacity based on mode, then reload Ghostty
    if test "$theme_mode" = "light"
        echo "background-opacity = 0.92" >> ~/.config/ghostty/colors.conf
    else
        echo "background-opacity = 0.78" >> ~/.config/ghostty/colors.conf
    end
    pkill -USR1 -x ghostty 2>/dev/null; true

    echo "Theme successfully regenerated!"
end
