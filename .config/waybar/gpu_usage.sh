#!/bin/bash
# 简单的脚本获取 NVIDIA GPU 使用率
# 如果你需要显示 Intel 使用率，由于 intel-gpu-top 需要 root，通常建议只显示 NVIDIA

nv_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)
nv_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)
nv_mem=$(nvidia-smi --query-gpu=utilization.memory --format=csv,noheader,nounits 2>/dev/null | head -n1)
nv_model=$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | head -n1)

if [ -z "$nv_usage" ]; then
    nv_usage=0
    nv_temp=0
    nv_mem=0
    nv_model="N/A"
fi

# Tooltip 文本
tooltip="GPU: $nv_model\nUsage: $nv_usage%\nMemory: $nv_mem%\nTemp: $nv_temp°C"

# JSON 输出给 Waybar
echo "{\"text\": \"󰢮 $nv_usage%\", \"tooltip\": \"$tooltip\"}"
