function ff
    set random_img (random choice ~/.config/fastfetch/imgs/*)
    fastfetch \
        --logo-type kitty \
        --logo-width 35 \
        --logo-padding-top 2 \
        --logo-padding-left 2 \
        --logo $random_img
end
