-- vim:fileencoding=utf-8:foldmethod=marker
--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/configuring/core/rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

------------------
---- NOCTALIA ----
------------------

-- Noctalia Settings
hl.window_rule({
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})

hl.layer_rule({
  name = "noctalia-no-anim",
  match = {
    namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
  },
  no_anim = true,
})

hl.layer_rule({
  name = "noctalia-blur",
  match = {
    namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
  },
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})

-------------
---- MEU ----
-------------
-- hyprctl clients para listar todos janelas abertas
-- https://wiki.hypr.land/configuring/core/rules/window-rules/

hl.window_rule({
    match = { class = "kitty" },
    float = true,
    size = { 1290, 900 },
})

hl.window_rule({
    match = { class = "firefox", title = "Picture-in-Picture" },
    float = true,
    pin = true,
    size = { 740, 420 },
})

hl.window_rule({
    match = { class = "org.keepassxc.KeePassXC" },
    float = true,
    size = { 1200, 800 },
})

hl.window_rule({
    match = { class = "org.gnome.Nautilus" },
    float = true,
    size = { 1000, 700 },
})

hl.window_rule({
    match = { class = "org.pulseaudio.pavucontrol" },
    float = true,
    size = { 1000, 700 },
})

