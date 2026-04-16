#!/bin/bash

# CPU Usage
cpu_usage=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f", usage}')

# CPU Temperature (try different hwmon if hwmon7 is not correct)
# I'll try to find the package temp
temp_file=""
for h in /sys/class/hwmon/hwmon*; do
    if [ -f "$h/temp1_input" ]; then
        name=$(cat "$h/name" 2>/dev/null)
        if [[ "$name" == "coretemp" || "$name" == "k10temp" ]]; then
            temp_file="$h/temp1_input"
            break
        fi
    fi
done

if [ -z "$temp_file" ]; then
    # Fallback if no specific temp file found
    cpu_temp="0"
else
    cpu_temp=$(cat "$temp_file" | awk '{printf "%.0f", $1/1000}')
fi

# Class based on usage (Adjusted thresholds: 0-40 low, 40-75 medium, 75-90 high, 90+ critical)
if [ "$cpu_usage" -lt 40 ]; then class="low";
elif [ "$cpu_usage" -lt 75 ]; then class="medium";
elif [ "$cpu_usage" -lt 90 ]; then class="high";
else class="critical"; fi

# Tooltip
tooltip="CPU Usage: $cpu_usage%\nTemp: $cpu_temp°C"

# JSON output
echo "{\"text\": \"󰍛\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
