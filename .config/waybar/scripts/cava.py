#!/usr/bin/env python3
# ~/.config/waybar/scripts/cava.py
# High-frequency plain text CAVA stream for Waybar (15 FPS)
# Optimized for minimal CPU consumption, absolutely no tooltips to avoid GTK lockups.

import sys
import subprocess
import time

def main():
    # Start cava subprocess in continuous stream mode
    cava_proc = subprocess.Popen(
        ["stdbuf", "-oL", "-eL", "cava", "-p", "/home/fuyu/.config/waybar/cava.conf"],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
    )

    BAR_MAP = [" ", "▂", "▃", "▄", "▅", "▆", "▇", "█"]
    FRAME_INTERVAL = 1.0 / 15.0
    last_print = 0.0

    try:
        while True:
            line = cava_proc.stdout.readline()
            if not line:
                break

            parts = line.strip().split(";")
            bars = "".join(BAR_MAP[int(p)] for p in parts if p.isdigit())
            if not bars:
                continue

            now = time.time()
            if now - last_print < FRAME_INTERVAL:
                continue
            last_print = now

            # Print raw unicode bar visualizer to stdout
            sys.stdout.write(bars + "\n")
            sys.stdout.flush()

    except KeyboardInterrupt:
        pass
    finally:
        cava_proc.terminate()

if __name__ == "__main__":
    main()
