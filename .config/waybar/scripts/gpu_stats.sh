#!/bin/bash

# NVIDIA GPU
nv_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)
nv_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)
nv_model="NVIDIA GeForce RTX 4060 Max-Q / Mobile [Discrete]"

# Defaults if empty
nv_usage=${nv_usage:-0}
nv_temp=${nv_temp:-0}

# Class based on usage (Adjusted thresholds)
if [ "$nv_usage" -lt 40 ]; then class="low";
elif [ "$nv_usage" -lt 75 ]; then class="medium";
elif [ "$nv_usage" -lt 90 ]; then class="high";
else class="critical"; fi

# Tooltip (Only NVIDIA)
tooltip="<b>$nv_model</b>\nUsage: $nv_usage%\nTemp: $nv_temp°C"

# JSON output
echo "{\"text\": \"󰢮\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
