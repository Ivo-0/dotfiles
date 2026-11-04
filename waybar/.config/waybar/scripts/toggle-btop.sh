#!/bin/bash

TOGGLE_FILE="/tmp/btop-open"

if [ -f "$TOGGLE_FILE" ]; then
    rm "$TOGGLE_FILE"
    pkill -f "btop"
else
    # Read current theme
    current_theme=$(cat ~/.config/waybar/current-theme 2>/dev/null || echo "night")
    
    if [ "$current_theme" = "day" ]; then
        BTOP_CONF="/home/ivo/.config/btop/btoplight.conf"
    else
        BTOP_CONF="/home/ivo/.config/btop/btopdark.conf"
    fi

    touch "$TOGGLE_FILE"
    kitty --title sysstat -e btop -c "$BTOP_CONF" &
fi