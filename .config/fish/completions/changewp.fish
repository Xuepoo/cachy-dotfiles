# ~/.config/fish/completions/changewp.fish
complete -c changewp -f
complete -c changewp -a "(ls -1 ~/Pictures/Wallpapers/ | string match -r '.*\.(jpg|png|jpeg)')" -d "Wallpaper"
