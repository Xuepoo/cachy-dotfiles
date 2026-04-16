#!/bin/bash
# Waybar Day/Night Theme Toggle
# Defaults to Day (wlsunset not running)

STATE_FILE="/tmp/waybar_theme_state"

if [ ! -f "$STATE_FILE" ]; then
    echo "day" > "$STATE_FILE"
fi

CURRENT_STATE=$(cat "$STATE_FILE")

if [ "$CURRENT_STATE" == "day" ]; then
    # Toggle to Night
    wlsunset -l 39.9 -L 116.3 -t 3500 -T 6500 &
    echo "night" > "$STATE_FILE"
    notify-send "Night Mode" "Wlsunset activated (Warm color temperature)" -i weather-clear-night
else
    # Toggle to Day
    pkill wlsunset
    echo "day" > "$STATE_FILE"
    notify-send "Day Mode" "Wlsunset deactivated (Natural color temperature)" -i weather-clear
fi
