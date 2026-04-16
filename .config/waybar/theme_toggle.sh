#!/bin/bash
STATE_FILE="/tmp/waybar_theme_state"

if [ ! -f "$STATE_FILE" ]; then
    echo "day" > "$STATE_FILE"
fi

current=$(cat "$STATE_FILE")

if [ "$current" == "day" ]; then
    # 切换到黑夜模式的指令（示例，你可以根据需要修改，比如切换 hyprland 颜色或 gsettings）
    # gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    echo "night" > "$STATE_FILE"
    notify-send "Theme Switched" "Dark Mode Activated" -i weather-clear-night
else
    # 切换到白天模式的指令
    # gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    echo "day" > "$STATE_FILE"
    notify-send "Theme Switched" "Light Mode Activated" -i weather-clear
fi
