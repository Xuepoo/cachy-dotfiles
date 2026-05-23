#!/usr/bin/env python3
# ~/.config/waybar/scripts/mpd_tooltip.py
# Queries MPD player state and outputs highly styled Pango markup for Waybar tooltips.

import sys
import json
import subprocess

def get_colors():
    """Parses ~/.config/waybar/colors.css to extract Matugen design colors."""
    colors = {
        "accent": "#ffb4a6",
        "foreground": "#f9dcd7",
        "mauve": "#f3ba9c",
        "yellow": "#f7ba7f",
        "red": "#ffb4ab",
        "surface1": "#392825"
    }
    try:
        import os, re
        css_path = os.path.expanduser("~/.config/waybar/colors.css")
        if os.path.exists(css_path):
            with open(css_path, "r") as f:
                content = f.read()
            for name in colors.keys():
                match = re.search(fr"@define-color\s+{name}\s+(#[0-9a-fA-F]+);", content)
                if match:
                    colors[name] = match.group(1)
    except Exception:
        pass
    return colors

def query_mpd_tooltip():
    """Queries current MPD state using mpc and formats a comprehensive, styled info card."""
    try:
        # Fetch detailed metadata formatting title, artist, album, and playing state
        out = subprocess.check_output(
            ["mpc", "-f", "%title%\n%artist%\n%album%\n%file%"],
            text=True, stderr=subprocess.DEVNULL, timeout=1.5
        ).strip()
        lines = out.split("\n")

        # Check if MPD is active (playing or paused)
        if len(lines) >= 3 and ("[playing]" in lines[-2] or "[paused]" in lines[-2]):
            meta = lines[:-2]
            title = meta[0].strip() if len(meta) > 0 and meta[0].strip() else "Unknown Title"
            artist = meta[1].strip() if len(meta) > 1 and meta[1].strip() else "Unknown Artist"
            album = meta[2].strip() if len(meta) > 2 and meta[2].strip() else "Unknown Album"

            status_line = lines[-2].strip()
            opts_line = lines[-1].strip()

            is_playing = "[playing]" in status_line
            state_text = "Playing" if is_playing else "Paused"

            # Parse time progress (e.g., 2:06/2:37) and percentage (e.g., (80%))
            time_part = ""
            pct_part = ""
            parts = status_line.split()
            for p in parts:
                if "/" in p and ":" in p:
                    time_part = p
                if p.startswith("(") and p.endswith("%)"):
                    pct_part = p[1:-1]

            pct_val = 0
            if pct_part:
                try:
                    pct_val = int(pct_part.replace("%", ""))
                except ValueError:
                    pass

            # Choose dynamic progress icon if playing, else use pause icon
            if is_playing:
                if pct_val <= 12:
                    state_icon = "󰪞"
                elif pct_val <= 25:
                    state_icon = "󰪟"
                elif pct_val <= 37:
                    state_icon = "󰪠"
                elif pct_val <= 50:
                    state_icon = "󰪡"
                elif pct_val <= 62:
                    state_icon = "󰪢"
                elif pct_val <= 75:
                    state_icon = "󰪣"
                elif pct_val <= 87:
                    state_icon = "󰪤"
                else:
                    state_icon = "󰪥"
            else:
                state_icon = "󰏤"

            # Extract Matugen theme colors
            colors = get_colors()
            accent = colors["accent"]
            yellow = colors["yellow"]
            mauve = colors["mauve"]
            foreground = colors["foreground"]
            surface1 = colors["surface1"]

            # Construct Pango markup content styled beautifully with dynamic theme colors
            tooltip = []
            tooltip.append(f"<big><span color='{accent}'><b>{state_icon} {state_text}</b></span></big>")
            tooltip.append(f"<span color='{surface1}'>────────────────────────────────────────</span>")
            tooltip.append(f"<span color='{accent}'><big><b>󰝚 </b></big></span> <span color='{foreground}'><b>{title}</b></span>")
            tooltip.append(f"<span color='{yellow}'><big><b>󰠃 </b></big></span> <span color='{foreground}'>{artist}</span>")
            tooltip.append(f"<span color='{mauve}'><big><b>󰀥 </b></big></span> <span color='{foreground}'>{album}</span>")
            tooltip.append(f"<span color='{surface1}'>────────────────────────────────────────</span>")

            if pct_part:
                # Colorize progress bar: accent for filled, surface1 for empty
                filled_blocks = pct_val // 5
                empty_blocks = 20 - filled_blocks
                progress_bar = f"<span color='{accent}'>{'█' * filled_blocks}</span><span color='{surface1}'>{'░' * empty_blocks}</span> <span color='{accent}'><b>{pct_val}%</b></span>"

                tooltip.append(f"<span color='{accent}'><b>Progress:</b></span>")
                tooltip.append(f"<tt>{progress_bar}</tt>")
                if time_part:
                    tooltip.append(f"<tt>  <span color='{mauve}'>{time_part}</span></tt>")
                tooltip.append(f"<span color='{surface1}'>────────────────────────────────────────</span>")

            if opts_line:
                tooltip.append(f"<span color='{accent}'><b>Player Settings:</b></span>")
                tooltip.append(f"<tt><span color='{foreground}'>{opts_line}</span></tt>")

            return state_icon, "\n".join(tooltip)

        # MPD is stopped but running
        elif len(lines) == 1 and "volume:" in lines[0]:
            tooltip = (
                "<big><b>󰎈 Music Player Daemon</b></big>\n\n"
                "<b>󰓛 Stopped</b>\n\n"
                f"<tt>{lines[0].strip()}</tt>"
            )
            return "󰓛", tooltip
        else:
            return "󰎆", "<big><b>󰎈 Music Player Daemon</b></big>\n\nNo music playing"

    except Exception:
        return "󰎆", "<big><b>󰎈 Music Player Daemon</b></big>\n\nMPD not available"

def main():
    icon, tooltip_content = query_mpd_tooltip()
    data = {
        "text": icon,
        "tooltip": tooltip_content
    }
    sys.stdout.write(json.dumps(data, ensure_ascii=False) + "\n")
    sys.stdout.flush()

if __name__ == "__main__":
    main()
