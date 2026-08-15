#!/usr/bin/env bash
# OBS record control for Hyprland keybinds
# Usage: obs-record.sh start|stop
#
# Requires:
#   - obs-websocket server enabled in OBS (Tools → WebSocket Server Settings)
#   - password stored in .obs-ws-password (same dir, chmod 600)
#   - obs-cmd installed (cargo install obs-cmd)
#
# Behavior:
#   start + OBS not running → launch OBS with --startrecording (cold start)
#   start + OBS running     → obs-cmd record start via websocket
#   stop  + OBS running     → obs-cmd record stop via websocket
#   stop  + OBS not running → no-op

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PASSWORD_FILE="$SCRIPT_DIR/.obs-ws-password"
ACTION="${1:-}"

if [[ "$ACTION" != "start" && "$ACTION" != "stop" ]]; then
    echo "usage: $0 start|stop" >&2
    exit 1
fi

# --- Cold start / no-op paths -------------------------------------------
if ! pgrep -x obs >/dev/null 2>&1; then
    if [[ "$ACTION" == "start" ]]; then
        nohup obs --startrecording >/dev/null 2>&1 &
    fi
    exit 0
fi

# --- OBS running: control via obs-websocket ------------------------------
if [[ ! -r "$PASSWORD_FILE" ]]; then
    notify-send -a "OBS" "websocket password file missing: $PASSWORD_FILE" 2>/dev/null || true
    exit 1
fi

export OBS_WEBSOCKET_URL="obsws://127.0.0.1:4455/$(cat "$PASSWORD_FILE")"

if ! command -v obs-cmd >/dev/null 2>&1; then
    notify-send -a "OBS" "obs-cmd not installed (cargo install obs-cmd)" 2>/dev/null || true
    exit 1
fi

case "$ACTION" in
    start)
        if obs-cmd recording start >/dev/null 2>&1; then
            notify-send -a "OBS" "录制已开始 🎬"
        else
            notify-send -a "OBS" "开始录制失败：请检查 WebSocket Server 是否已启用" -u critical
            exit 1
        fi
        ;;
    stop)
        if obs-cmd recording stop >/dev/null 2>&1; then
            notify-send -a "OBS" "录制已停止 ⏹"
        else
            notify-send -a "OBS" "停止录制失败" -u critical
            exit 1
        fi
        ;;
esac
