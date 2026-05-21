#!/usr/bin/env python3
# ~/.config/waybar/scripts/backlight.py - Custom backlight helper displaying theme mode
import json
import os
import re

def get_theme_mode():
    try:
        fish_vars_path = os.path.expanduser("~/.config/fish/fish_variables")
        if os.path.exists(fish_vars_path):
            with open(fish_vars_path, "r") as f:
                content = f.read()
            match = re.search(r"SETUVAR theme_mode:(\w+)", content)
            if match:
                return match.group(1).lower()
    except Exception:
        pass
    return "dark"

def get_brightness():
    try:
        bright_path = "/sys/class/backlight/nvidia_0/brightness"
        max_bright_path = "/sys/class/backlight/nvidia_0/max_brightness"
        
        if os.path.exists(bright_path) and os.path.exists(max_bright_path):
            with open(bright_path, "r") as f:
                bright = int(f.read().strip())
            with open(max_bright_path, "r") as f:
                max_bright = int(f.read().strip())
            return int((bright / max_bright) * 100)
    except Exception:
        pass
    return 100

def main():
    mode = get_theme_mode()
    percent = get_brightness()
    
    # Select icon based on percentage
    if percent <= 20:
        icon = "🌑"
    elif percent <= 40:
        icon = "🌘"
    elif percent <= 60:
        icon = "🌗"
    elif percent <= 80:
        icon = "🌖"
    else:
        icon = "🌕"
        
    mode_text = "Light Mode ☀️" if mode == "light" else "Dark Mode 🌙"
    tooltip = f"Brightness: {percent}%\nTheme Mode: {mode_text}"
    
    data = {
        "text": icon,
        "tooltip": tooltip,
        "percentage": percent
    }
    
    print(json.dumps(data, ensure_ascii=False))

if __name__ == "__main__":
    main()
