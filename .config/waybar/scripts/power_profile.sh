#!/bin/bash

# Get current profile
current=$(powerprofilesctl get)

# Toggle logic
case $current in
    balanced)
        next="performance"
        icon=""
        ;;
    performance)
        next="power-saver"
        icon=""
        ;;
    power-saver)
        next="balanced"
        icon=""
        ;;
    *)
        next="balanced"
        icon=""
        ;;
esac

# If an argument "next" is passed, perform the switch
if [ "$1" == "next" ]; then
    powerprofilesctl set $next
    # Recursive call to get the new state for immediate feedback
    exec $0
else
    # Extract driver for tooltip
    driver=$(powerprofilesctl | grep -A 3 -E "^\*? *$current:" | awk '/CpuDriver:/ {print $2}')
    
    # Tooltip info
    tooltip="当前模式: $current\nCPU驱动: $driver"
    echo "{\"text\": \"$icon\", \"tooltip\": \"$tooltip\", \"class\": \"$current\"}"
fi