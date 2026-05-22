#!/usr/bin/env python3
# ~/.config/waybar/scripts/cava.py
# High-performance CAVA visualizer for Waybar with dynamic rich MPD/MPC tooltips

import sys
import json
import subprocess
import time

last_update = 0
cached_tooltip = "No music playing"
cached_class = "stopped"

def get_mpd_status():
    global last_update, cached_tooltip, cached_class
    now = time.time()
    # Rate limit to at most once per second to avoid high CPU usage
    if now - last_update < 1.0:
        return cached_tooltip, cached_class
    
    last_update = now
    try:
        # Run mpc without arguments
        output = subprocess.check_output(["mpc"], text=True, stderr=subprocess.DEVNULL).strip()
        lines = output.split('\n')
        if len(lines) >= 3:
            song = lines[0].strip()
            status = lines[1].strip()
            options = lines[2].strip()
            
            # Format status beautifully
            state = "playing" if "[playing]" in status else "paused"
            state_icon = "󰎆" if state == "playing" else "󰏤"
            
            tooltip = (
                f"<span foreground='#8be9fd'><big><b>󰎈 Music Player Daemon</b></big></span>\n\n"
                f"<b>{state_icon} Now Playing:</b>\n"
                f"<span foreground='#ff79c6'><b>{song}</b></span>\n\n"
                f"<b>📊 Progress:</b>\n"
                f"{status}\n\n"
                f"<b>🎛️ Settings:</b>\n"
                f"<span foreground='#a0a0a0'>{options}</span>"
            )
            cached_tooltip = tooltip
            cached_class = state
        elif len(lines) == 1 and "volume:" in lines[0]:
            # MPD is stopped
            cached_tooltip = (
                f"<span foreground='#8be9fd'><big><b>󰎈 Music Player Daemon</b></big></span>\n\n"
                f"<b>󰓛 Stopped</b>\n"
                f"<span foreground='#a0a0a0'>{lines[0].strip()}</span>"
            )
            cached_class = "stopped"
        else:
            cached_tooltip = "No music playing"
            cached_class = "stopped"
    except Exception:
        cached_tooltip = "MPD not running"
        cached_class = "stopped"
        
    return cached_tooltip, cached_class

def main():
    # Start CAVA in raw ascii mode as a subprocess
    cava_proc = subprocess.Popen(
        ["cava", "-p", "/home/fuyu/.config/waybar/cava.conf"],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True
    )
    
    MAP = [" ", "▂", "▃", "▄", "▅", "▆", "▇", "█"]
    
    try:
        while True:
            line = cava_proc.stdout.readline()
            if not line:
                break
                
            parts = line.strip().split(';')
            bars = "".join(MAP[int(p)] for p in parts if p.isdigit())
            
            if not bars:
                continue
                
            tooltip, css_class = get_mpd_status()
            
            data = {
                "text": bars,
                "tooltip": tooltip,
                "class": css_class
            }
            
            sys.stdout.write(json.dumps(data, ensure_ascii=False) + "\n")
            sys.stdout.flush()
    except KeyboardInterrupt:
        pass
    finally:
        cava_proc.terminate()

if __name__ == "__main__":
    main()
