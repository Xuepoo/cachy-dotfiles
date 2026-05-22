function changewp --description "Change wallpaper and dynamically regenerate colors using Awww and Matugen"
    set -l wp_dir "$HOME/Pictures/Wallpapers"
    
    # 1. Parse arguments and handle flags
    set -l mode "normal"
    if test (count $argv) -eq 0
        set mode "random"
    else if contains -- $argv[1] "-r" "--random" "random"
        set mode "random"
    else if contains -- $argv[1] "-s" "--select" "select"
        set mode "select"
    end

    # 2. Route execution based on parsed mode
    if test "$mode" = "random"
        set -l files (find $wp_dir -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \))
        if test (count $files) -gt 0
            set -l rand_idx (random 1 (count $files))
            set argv $files[$rand_idx]
        else
            echo "Error: No wallpapers found in $wp_dir."
            return 1
        end
    else if test "$mode" = "select"
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
            echo "Error: Neither 'television' nor 'fzf' is installed for interactive selection."
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
    
    # 3. Set wallpaper using Awww with a randomized premium transition style
    set -l transition_choices "grow" "outer" "wipe" "wave" "fade"
    set -l rand_choice (random 1 (count $transition_choices))
    set -l transition_type $transition_choices[$rand_choice]
    
    set -l transition_args
    switch $transition_type
        case "grow"
            set transition_args --transition-type grow --transition-pos center --transition-duration 1.5 --transition-fps 90
        case "outer"
            set transition_args --transition-type outer --transition-pos center --transition-duration 1.5 --transition-fps 90
        case "wipe"
            set -l angles 0 30 45 90 135 180
            set -l rand_angle_idx (random 1 (count $angles))
            set transition_args --transition-type wipe --transition-angle $angles[$rand_angle_idx] --transition-duration 1.8 --transition-fps 90
        case "wave"
            set -l angles 30 45 60 120
            set -l rand_angle_idx (random 1 (count $angles))
            set transition_args --transition-type wave --transition-angle $angles[$rand_angle_idx] --transition-duration 1.8 --transition-fps 90
        case "fade"
            set transition_args --transition-type fade --transition-duration 1.2 --transition-fps 90
    end
    
    echo "Transition animation: $transition_type"
    /usr/bin/awww img "$wp_path" $transition_args
    
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
    pkill -USR2 -x ghostty 2>/dev/null; true

    echo "Theme successfully regenerated!"
end
