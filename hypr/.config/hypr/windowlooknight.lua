hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 12,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(00b4ffee)", "rgba(bf00ffee)" }, angle = 45 },
            inactive_border = "rgba(8800ffee)",
        },
        layout = "dwindle",
        resize_on_border = true,
        allow_tearing = false,
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        shadow = {
            enabled = true,
            range = 0,
            render_power = 0,
            color = "rgba(0, 56, 139, 1)",
        },
        blur = {
            enabled = true,
            size = 2,
            passes = 2,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
})
