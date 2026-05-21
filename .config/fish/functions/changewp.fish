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
    
    # 2. Generate theme using Matugen
    /home/fuyu/.local/share/cargo/bin/matugen -t scheme-vibrant image --source-color-index 0 "$wp_path"

    echo "Theme successfully regenerated!"
end
