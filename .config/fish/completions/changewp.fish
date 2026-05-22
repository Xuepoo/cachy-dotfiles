# ~/.config/fish/completions/changewp.fish
complete -c changewp -f
complete -c changewp -s r -l random -d "Randomly select and apply a wallpaper"
complete -c changewp -s s -l select -d "Interactively select a wallpaper using fzf/television"
complete -c changewp -a "(find ~/Pictures/Wallpapers/ -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' \) | string replace \"$HOME/Pictures/Wallpapers/\" \"\")" -d "Wallpaper"
