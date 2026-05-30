hl.bind("SUPER + B", function ()
    local game_mode = (hl.get_config("decoration.shadow.enabled") == false)

    if game_mode then
        hl.exec_cmd("hyprctl reload")
        return
    end
    
    hl.config({
        decoration = {
        	inactive_opacity = 1.0,
            shadow = { enabled = false },
        }
    })
end)

