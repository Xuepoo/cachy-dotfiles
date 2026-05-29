#!/usr/bin/env python3
import sys
import json
import psutil

def get_cpu_info():
    # Measure over 0.05 seconds to avoid blocking Waybar UI thread.
    cpu_usage = psutil.cpu_percent(interval=0.05)
    
    # Get average CPU frequency
    try:
        cpu_freq = psutil.cpu_freq().current / 1000.0
    except Exception:
        cpu_freq = 0.0
        
    # Get package temperature and individual core temperatures
    temps = psutil.sensors_temperatures()
    package_temp = 0.0
    core_temps = []
    
    if 'coretemp' in temps:
        for t in temps['coretemp']:
            if t.label == 'Package id 0':
                package_temp = t.current
            elif t.label.startswith('Core'):
                try:
                    # Parse core number (e.g. "Core 0" -> 0)
                    core_num = int(t.label.split()[1])
                except Exception:
                    core_num = 999
                core_temps.append((core_num, t.current))
    else:
        # Fallback to any sensor containing "cpu" or "package" in the label
        for entries in temps.values():
            for entry in entries:
                if 'package' in entry.label.lower() or 'cpu' in entry.label.lower():
                    package_temp = entry.current
                    break
    
    # Sort core temperatures numerically by core number
    core_temps.sort(key=lambda x: x[0])
    
    # Get per-logical-cpu usage
    per_cpu_usage = psutil.cpu_percent(percpu=True)
    
    # Text displayed on the bar: CPU usage icon + percentage + temperature icon + package temperature
    text = f"󰍛 {cpu_usage:2.0f}%  {package_temp:.0f}°C"
    
    # Build a gorgeous, perfectly-aligned tooltip using Pango markup
    tooltip = []
    tooltip.append(f"<big><b>CPU Usage: {cpu_usage:.1f}%</b></big>")
    tooltip.append(f"Average Frequency: {cpu_freq:.2f} GHz\n")
    
    # Logical Cores Usage grid (4 columns)
    tooltip.append("<big><b>Logical Cores Usage:</b></big>")
    thread_lines = []
    num_threads = len(per_cpu_usage)
    for i in range(0, num_threads, 4):
        cols = []
        for j in range(4):
            idx = i + j
            if idx < num_threads:
                cols.append(f"CPU {idx:02d}: {per_cpu_usage[idx]:3.0f}%")
        thread_lines.append("  ".join(cols))
    tooltip.append("<tt>" + "\n".join(thread_lines) + "</tt>\n")
    
    # Core Temperatures grid (4 columns)
    if core_temps:
        tooltip.append("<big><b>Core Temperatures:</b></big>")
        temp_lines = []
        num_cores = len(core_temps)
        for i in range(0, num_cores, 4):
            cols = []
            for j in range(4):
                idx = i + j
                if idx < num_cores:
                    c_num, c_temp = core_temps[idx]
                    cols.append(f"Core {c_num:02d}: {c_temp:3.0f}°C")
            temp_lines.append("  ".join(cols))
        tooltip.append("<tt>" + "\n".join(temp_lines) + "</tt>")
    
    # Dynamic thresholds for CSS styling class
    # Usage warning > 50%, critical > 80%
    # Temperature warning > 70°C, critical > 85°C
    css_class = "good"
    if cpu_usage > 80 or package_temp > 85:
        css_class = "critical"
    elif cpu_usage > 50 or package_temp > 70:
        css_class = "warning"
        
    data = {
        "text": text,
        "tooltip": "\n".join(tooltip),
        "class": css_class,
        "percentage": int(cpu_usage)
    }
    
    return data

if __name__ == "__main__":
    try:
        info = get_cpu_info()
        print(json.dumps(info, ensure_ascii=False))
    except Exception as e:
        err_data = {
            "text": "󰍛 CPU Error",
            "tooltip": str(e)
        }
        print(json.dumps(err_data, ensure_ascii=False))
