function togglemode --description "Toggle between light and dark theme modes using Matugen"
    if not set -q theme_mode
        set -U theme_mode dark
    end

    if test "$theme_mode" = "dark"
        set -U theme_mode light
    else
        set -U theme_mode dark
    end

    if not set -q current_wallpaper; or not test -f "$current_wallpaper"
        # Fallback to the first wallpaper if not set
        set -l wp_dir "$HOME/Pictures/Wallpapers"
        set -l default_wp (find $wp_dir -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | head -n 1)
        if test -n "$default_wp"
            set -U current_wallpaper "$default_wp"
        else
            echo "Error: No current wallpaper set and no wallpapers found in $wp_dir."
            return 1
        end
    end

    echo "Toggling theme mode to: $theme_mode"
    echo "Regenerating theme for: $current_wallpaper"

    /home/fuyu/.local/share/cargo/bin/matugen --contrast 0.15 -t scheme-vibrant -m $theme_mode image --source-color-index 0 "$current_wallpaper"
    
    # Dynamically adjust Ghostty background opacity for optimal readability
    if test "$theme_mode" = "light"
        echo "background-opacity = 0.96" >> ~/.config/ghostty/colors.conf
    else
        echo "background-opacity = 0.78" >> ~/.config/ghostty/colors.conf
    end

    echo "Theme successfully regenerated in $theme_mode mode!"

    if test "$theme_mode" = "light"
        notify-send "Theme Switch" "Switched to Light Mode ☀️"
    else
        notify-send "Theme Switch" "Switched to Dark Mode 🌙"
    end
end
