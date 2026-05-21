#!/usr/bin/env python3
import subprocess
import sys
import time

def send_notification(player, title, artist, status):
    # Normalize player name
    player_display = player.capitalize()
    if player_display == "Mpd":
        player_display = "Music Player Daemon"
    
    # Select icon based on player
    icon_name = "audio-x-generic"
    player_lower = player.lower()
    if "spotify" in player_lower:
        icon_name = "spotify-client"
    elif "firefox" in player_lower:
        icon_name = "firefox"
    elif "chrome" in player_lower or "chromium" in player_lower:
        icon_name = "chromium"

    if status.lower() == "paused":
        summary = f"Paused ({player_display})"
        body = f"{title}\nby {artist}" if artist else title
    else:
        summary = f"Now Playing ({player_display})"
        body = f"<b>{title}</b>\nby {artist}" if artist else f"<b>{title}</b>"

    cmd = [
        "notify-send",
        "-r", "9998",  # Keep notification ID constant to replace previous media notification
        "-a", player_display,
        "-i", icon_name,
        summary,
        body
    ]
    try:
        subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except Exception:
        pass

def main():
    cmd = ["playerctl", "--follow", "metadata", "--format", "{{status}}::{{player_name}}::{{artist}}::{{title}}"]
    try:
        proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True)
    except Exception:
        print("Failed to start playerctl", file=sys.stderr)
        return

    last_track = None
    last_status = None

    for line in proc.stdout:
        line = line.strip()
        if not line:
            continue
        parts = line.split("::")
        if len(parts) < 4:
            continue
        status, player, artist, title = parts[0], parts[1], parts[2], parts[3]
        
        if not title and not artist:
            continue
            
        track_id = (player, artist, title)
        
        if track_id != last_track or status != last_status:
            if status.lower() in ["playing", "paused"]:
                send_notification(player, title, artist, status)
            last_track = track_id
            last_status = status

if __name__ == "__main__":
    # Wait for desktop services to load
    time.sleep(3)
    main()
