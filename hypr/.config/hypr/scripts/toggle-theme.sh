#!/bin/bash

# Check current theme
current=$(cat ~/.config/waybar/current-theme 2>/dev/null || echo "night")

if [ "$current" = "night" ]; then
    # Switch to day
    cp ~/.config/waybar/style-day.css ~/.config/waybar/style.css
    gsettings set org.gnome.desktop.interface gtk-theme "Orchis-Light"
    hyprctl keyword general:col.active_border "rgba(00ffd9ed) rgba(ffd600ee) 45deg"
    hyprctl keyword general:col.inactive_border "rgba(ffb30044)"
    echo "day" > ~/.config/waybar/current-theme
else
    # Switch to night
    cp ~/.config/waybar/style-night.css ~/.config/waybar/style.css
    gsettings set org.gnome.desktop.interface gtk-theme "Orchis-Dark"
    hyprctl keyword general:col.active_border "rgba(00b4ffee) rgba(bf00ffee) 45deg"
    hyprctl keyword general:col.inactive_border "rgba(1e2a4aaa)"
    echo "night" > ~/.config/waybar/current-theme
fi

# Restart waybar to apply new style
killall waybar && waybar & disown
