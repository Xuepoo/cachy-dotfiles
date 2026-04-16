#!/bin/bash

# CPU 信息获取
cpu_usage=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f", usage}')
cpu_temp=$(cat /sys/class/hwmon/hwmon7/temp1_input | awk '{printf "%.0f", $1/1000}')

# NVIDIA 信息获取
nv_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)
nv_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)
nv_usage=${nv_usage:-0}
nv_temp=${nv_temp:-0}

# Intel 信息获取 (尝试从 sysfs 获取简单负载)
# intel-gpu-top 需要 root，我们优先从 sysfs 的 render 频率比例估算，或者直接显示频率
intel_freq=$(cat /sys/class/drm/card1/gt_cur_freq_mhz 2>/dev/null || echo 0)
intel_max_freq=$(cat /sys/class/drm/card1/gt_max_freq_mhz 2>/dev/null || echo 1)
intel_usage=$((intel_freq * 100 / intel_max_freq))

# 分类函数：根据使用率返回颜色类名
get_class() {
    local val=$1
    if [ "$val" -lt 30 ]; then echo "low";
    elif [ "$val" -lt 60 ]; then echo "medium";
    elif [ "$val" -lt 85 ]; then echo "high";
    else echo "critical"; fi
}

case $1 in
    cpu)
        echo "{\"text\": \"󰍛\", \"tooltip\": \"CPU Usage: $cpu_usage%\nTemp: $cpu_temp°C\", \"class\": \"$(get_class $cpu_usage)\"}"
        ;;
    cpu_temp)
        echo "{\"text\": \"$cpu_temp°C\", \"class\": \"$(get_class $cpu_usage)\"}"
        ;;
    gpu_nv)
        echo "{\"text\": \"󰢮\", \"tooltip\": \"NVIDIA GeForce RTX 4060 Max-Q / Mobile [Discrete]\nUsage: $nv_usage%\nTemp: $nv_temp°C\", \"class\": \"$(get_class $nv_usage)\"}"
        ;;
    gpu_intel)
        echo "{\"text\": \"󰻑\", \"tooltip\": \"Intel Raptor Lake-S UHD Graphics @ 1.60 GHz [Integrated]\nFreq: $intel_freq MHz\nUsage: $intel_usage%\", \"class\": \"$(get_class $intel_usage)\"}"
        ;;
    gpu_nv_temp)
        echo "{\"text\": \"$nv_temp°C\", \"class\": \"$(get_class $nv_usage)\"}"
        ;;
    gpu_intel_temp)
        # Intel 核显通常没有独立的 hwmon 温度，一般看 CPU 温度
        echo "{\"text\": \"$cpu_temp°C\", \"class\": \"$(get_class $intel_usage)\"}"
        ;;
esac
