function osu --description 'Launch osu!lazer with Wayland native and NVIDIA dGPU'
    # 强制 SDL2 使用 Wayland 协议
    set -gx SDL_VIDEODRIVER wayland
    
    # 优化 NVIDIA 驱动的同步行为以降低延迟
    set -gx __GL_GSYNC_ALLOWED 0
    set -gx __GL_VRR_ALLOWED 0

    systemctl --user start opentabletdriver.service

    # 使用 prime-run 调用 RTX 4060
    prime-run osu-lazer > /dev/null 2>&1 &
end
