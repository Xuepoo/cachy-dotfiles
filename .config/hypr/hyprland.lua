-- ~/.config/hypr/hyprland.lua
-- Hyprland Lua Configuration (v0.55+ standard)
-- Refer to https://wiki.hypr.land/Configuring/Start/

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- GPU & Wayland environment
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("NIXOS_OZONE_WL", "1")

-- Load dynamically generated theme colors
local colors = {
    active_border = { colors = { "rgba(005876ff)", "rgba(00b4ec8e)" }, angle = 30 },
    inactive_border = "rgba(dae4ecaa)",
}

local colors_ok, loaded_colors = pcall(require, "colors")
if colors_ok and type(loaded_colors) == "table" then
    colors = loaded_colors
end

------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "2560x1600@240",
    position = "0x0",
    scale    = 1.600,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "-1920x0",
    scale    = 1.000,
})

---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "ghostty"
local fileManager = "superfile"
local menu        = "wofi"

-------------------
---- AUTOSTART ----
-------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("fcitx5 -d --replace")
    hl.exec_cmd("/home/fuyu/.config/hypr/scripts/mpris_notifier.py")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 15,

        border_size = 2,

        col = {
            active_border   = colors.active_border,
            inactive_border = colors.inactive_border,
        },

        resize_on_border = true,
        allow_tearing    = true,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },

    debug = {
        vfr = true,
    },

    render = {
        direct_scanout = true,
    },

    cursor = {
        hide_on_key_press   = true,
        no_hardware_cursors = true,
        use_cpu_buffer      = true,
    },

    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "caps:escape",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = true,
        },

        tablet = {
            output = "eDP-1",
        },
    },

    xwayland = {
        force_zero_scaling = true,
    },
})

--------------------
---- ANIMATIONS ----
--------------------
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

------------------
---- GESTURES ----
------------------
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

---------------------------
---- PER-DEVICE CONFIG ----
---------------------------
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- Core application & window binds
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("fish -c changewp"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("fish -c togglemode"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist list | wofi --show dmenu --matching fuzzy --with-nth 2 | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("wofi --show drun --matching fuzzy"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("hermes-input"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("wofi-files"))
hl.bind(mainMod .. " + CTRL + D", hl.dsp.exec_cmd("wofi-zoxide"))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("pkill wofi || " .. menu .. " --show window"))
hl.bind(mainMod .. " + space", hl.dsp.window.center())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind("Print", hl.dsp.exec_cmd("grimlast copy area"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/screenshot.sh"))
hl.bind(mainMod .. " + CTRL + SHIFT + A", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/obs-record.sh start"))
hl.bind(mainMod .. " + CTRL + SHIFT + S", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/obs-record.sh stop"))
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("pkill fcitx5 || fcitx5"))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("quick-translate.sh"))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exec_cmd("mpd_fav"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("mpc prev"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("mpc toggle"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("mpc next"))

-- Single-hand friendly Return shortcut
hl.bind("CTRL + Escape", hl.dsp.send_shortcut({ mods = "", key = "Return" }))

-- Focus movements
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + PageUp",   hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + PageDown", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + Tab",         hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "e+1" }))

-- Workspace switching & moving windows to workspace [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Window drag / resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("mouse:274",               hl.dsp.window.drag(),   { mouse = true })

-- Repeating resize with keyboard
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 30,  y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -30, y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -30,relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L",     hl.dsp.window.resize({ x = 30,  y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + H",     hl.dsp.window.resize({ x = -30, y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K",     hl.dsp.window.resize({ x = 0,   y = -30,relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J",     hl.dsp.window.resize({ x = 0,   y = 30, relative = true }), { repeating = true })

-- Multimedia / Hardware keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

----------------------
---- WINDOW RULES ----
----------------------
-- Ignore maximize requests from all apps
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix dragging issues with XWayland
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

-- Floating utility windows
hl.window_rule({
    name  = "float-windows",
    match = {
        class = "^(org\\.pulseaudio\\.pavucontrol|nm-connection-editor|com\\.gabm\\.satty|clash-verge|io\\.github\\.kaii_lb\\.Overskride)$",
    },
    float = true,
})

-- Nautilus floating & center
hl.window_rule({
    name   = "nautilus-floating",
    match  = { class = "^(org\\.gnome\\.Nautilus|nautilus)$" },
    float  = true,
    size   = { 1000, 650 },
    center = true,
})

-- Osu Game rules
hl.window_rule({
    name      = "osu-rules",
    match     = { class = "^(osu!)$" },
    immediate = true,
    opaque    = true,
    no_blur   = true,
    no_shadow = true,
})

---------------------
---- LAYER RULES ----
---------------------
hl.layer_rule({
    name    = "waybar-noanim",
    match   = { namespace = "waybar" },
    no_anim = true,
})

hl.layer_rule({
    name         = "wofi-rules",
    match        = { namespace = "wofi" },
    blur         = true,
    ignore_alpha = 0,
})
