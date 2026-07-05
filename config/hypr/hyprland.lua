hl.monitor({
    output = "",
    mode = "preffered",
    position = "auto",
    scale = "auto",
})

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

hl.on("hyprland.start", function ()
    hl.exec_cmd("hyprpaper & waybar & udiskie --smart-tray --open \"foot -e yazi\"")
end)

local mod = "SUPER"

hl.bind(mod .. " + Return", hl.dsp.exec_cmd("foot"))
hl.bind(mod .. " + Backspace", hl.dsp.window.close())
hl.bind(mod .. " + b", hl.dsp.exec_cmd("firefox"))
hl.bind(mod .. " + Tab", hl.dsp.exec_cmd("foot yazi"))
hl.bind(mod .. " + Space", hl.dsp.exec_cmd("rofi -show drun -show-power-menu"))
hl.bind(mod .. " + o", hl.dsp.exec_cmd("foot -e opencode"))

hl.bind(mod .. " + minus", hl.dsp.focus({ workspace = "prev" }))
hl.bind(mod .. " + equal", hl.dsp.focus({ workspace = "next" }))
hl.bind(mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Region Select Screenshot
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp -d)\" - | wl-copy"))
-- Fullscreen Screenshot to clipboard
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim - | wl-copy"))
-- Region Select saved as PNG to Screenshots dir
hl.bind("SUPER + Print", hl.dsp.exec_cmd("grim -g \"$(slurp -d)\" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"))

hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl set 10%-"))
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl set +10%"))

for i = 1, 5 do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end 

hl.config({ decoration = { active_opacity = 0.7 } })
hl.config({ decoration = { inactive_opacity = 0.4 } })
hl.config({ decoration = { rounding = 12 } })

hl.config({ decoration = { shadow = { range = 10 } } })
hl.config({ decoration = { shadow = { render_power = 2 } } })
hl.config({ decoration = { shadow = { color = 0x88000000 } } })
hl.config({ decoration = { shadow = { offset = {2,4} } } })

hl.config({ general = { border_size = 0 } })
hl.config({ general = { gaps_in = 4 } })
hl.config({ general = { gaps_out = 8 } })

hl.window_rule({
    match = { class = "firefox" },
    opacity = "1 override"
})
hl.window_rule({
    match = { class = "rofi" },
    xray = true
})
hl.window_rule({
    match = { title = "^(File Picker)$" },
    xray = true,
    float = true,
    center = true,
    size = "40% 40%"
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 3,
    spring = "default",
    style = "slidefade 20%"
})
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 3,
    spring = "default",
    style = "popin 80%"
})
hl.animation({ leaf = "fade", enabled = true, speed = 3, spring = "default" })
