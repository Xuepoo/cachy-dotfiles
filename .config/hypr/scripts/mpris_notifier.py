#!/usr/bin/env python3
# ~/.config/hypr/scripts/mpris_notifier.py - Asynchronous media change notifications daemon
import subprocess
import sys
import time
import threading

# Thread safety lock
state_lock = threading.Lock()

# Dictionary to store active timers: {player: Timer}
active_timers = {}

# Dictionary to store pending track notifications: {player: (artist, title)}
pending_tracks = {}

# Dictionary to store last successfully notified track: {player: (artist, title)}
last_notified_tracks = {}

def is_ad(player, title, artist):
    player_lower = player.lower()
    title_lower = title.lower() if title else ""
    artist_lower = artist.lower() if artist else ""
    
    # Spotify advertisement filters
    if "spotify" in player_lower:
        if title_lower in ["advertisement", "ad", "spotify"] or artist_lower == "spotify" or not artist.strip():
            return True
            
    # Generic advertisement filters
    if title_lower in ["advertisement", "ad"]:
        return True
        
    return False

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

def handle_play_timer_fire(player, title, artist):
    with state_lock:
        # Mark as successfully notified
        last_notified_tracks[player] = (artist, title)
        # Clean up the timer and pending references
        if player in active_timers:
            del active_timers[player]
        if player in pending_tracks:
            del pending_tracks[player]
            
    send_notification(player, title, artist, "Playing")

def process_event(status, player, artist, title):
    status_lower = status.lower()
    player_strip = player.strip()
    
    if not player_strip or status_lower not in ["playing", "paused"]:
        return
        
    if is_ad(player_strip, title, artist):
        return

    track_id = (artist.strip(), title.strip())

    with state_lock:
        if status_lower == "playing":
            # Check if this track is already playing and was already notified
            if last_notified_tracks.get(player_strip) == track_id:
                return
                
            # Check if this track is already in pending queue
            if pending_tracks.get(player_strip) == track_id:
                return
                
            # If there was a different pending track, cancel its timer
            if player_strip in active_timers:
                active_timers[player_strip].cancel()
                del active_timers[player_strip]
                
            # Schedule a playing notification with a debounce of 1.2 seconds to filter hovers/scans
            timer = threading.Timer(1.2, handle_play_timer_fire, args=[player_strip, title, artist])
            active_timers[player_strip] = timer
            pending_tracks[player_strip] = track_id
            timer.start()
            
        elif status_lower == "paused":
            # Cancel any pending playing timer for this player since it was paused
            if player_strip in active_timers:
                active_timers[player_strip].cancel()
                del active_timers[player_strip]
            if player_strip in pending_tracks:
                del pending_tracks[player_strip]
                
            # Only send a pause notification if the user was previously notified of it playing
            if last_notified_tracks.get(player_strip) == track_id:
                send_notification(player_strip, title, artist, "Paused")
                # Clear last notified so we don't duplicate pause alerts
                del last_notified_tracks[player_strip]

def main():
    while True:
        cmd = ["playerctl", "--follow", "metadata", "--format", "{{status}}::{{playerName}}::{{artist}}::{{title}}"]
        try:
            proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True)
        except Exception:
            time.sleep(3)
            continue

        last_event = None

        for line in proc.stdout:
            line = line.strip()
            if not line:
                continue
            parts = line.split("::")
            if len(parts) < 4:
                continue
            status, player, artist, title = parts[0], parts[1], parts[2], parts[3]
            
            if not title.strip() and not artist.strip():
                continue
                
            event = (status.lower(), player.strip(), artist.strip(), title.strip())
            if event == last_event:
                continue
            last_event = event
            
            process_event(status, player, artist, title)

        # If playerctl exits (e.g. no active players), wait and retry to keep the daemon alive permanently
        proc.wait()
        time.sleep(3)

if __name__ == "__main__":
    # Wait for desktop environment services to load on startup
    time.sleep(3)
    main()
