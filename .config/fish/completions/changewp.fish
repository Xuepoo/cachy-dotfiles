# ~/.config/fish/completions/changewp.fish
complete -c changewp -f
complete -c changewp -a "(find ~/Pictures/Wallpapers/ -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' \) | string replace \"$HOME/Pictures/Wallpapers/\" \"\")" -d "Wallpaper"
