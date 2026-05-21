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
    echo "Theme successfully regenerated in $theme_mode mode!"
end
