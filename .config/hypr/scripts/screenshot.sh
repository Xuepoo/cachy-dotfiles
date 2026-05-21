#!/usr/bin/env bash
# ~/.config/hypr/scripts/screenshot.sh
# Wrapper: take screenshot with grim → annotate with satty → copy file:// path to clipboard

set -euo pipefail

SCREENSHOT_DIR="$HOME/Pictures/Screenshots/$(date +%Y-%m-%d)"
mkdir -p "$SCREENSHOT_DIR"

FILENAME="$SCREENSHOT_DIR/satty-$(date +%Y-%m-%d_%H-%M-%S).png"

# Take screenshot via grim+slurp, pipe to satty for annotation
# satty will save to the output-filename specified in its config.toml
# We watch for the newest file in the directory after satty exits
grim -g "$(slurp)" - | satty --filename - --output-filename "$FILENAME"

# After satty exits, if the file was saved, copy file:/// URI to clipboard
if [[ -f "$FILENAME" ]]; then
    printf "file://%s" "$FILENAME" | wl-copy
    notify-send "Screenshot saved" "file://$FILENAME" --icon=image-x-generic
fi
