#!/bin/bash

# Check current theme
current=$(cat ~/.config/waybar/current-theme 2>/dev/null || echo "night")

if [ "$current" = "night" ]; then
    # Switch to day
    cp ~/.config/waybar/style-day.css ~/.config/waybar/style.css
    gsettings set org.gnome.desktop.interface gtk-theme "Orchis-Purple-Light"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
    # Remove existing symlinks and copy day theme gtk4 files
    rm ~/.config/gtk-4.0/gtk.css
    rm ~/.config/gtk-4.0/gtk-dark.css
    rm -r ~/.config/gtk-4.0/assets
    cp /usr/share/themes/Orchis-Purple-Light/gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css
    cp /usr/share/themes/Orchis-Purple-Light/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css
    cp -r /usr/share/themes/Orchis-Purple-Light/gtk-4.0/assets ~/.config/gtk-4.0/
    ln -sf ~/.config/rofi/theme-day.rasi ~/.config/rofi/theme.rasi
    ln -sf ~/.config/swaync/style-day.css ~/.config/swaync/style.css
    swaync-client --reload-css
    kitten themes Kaolin Light
	cp ~/.config/hypr/windowlookday.lua ~/.config/hypr/windowlook.lua
    cp ~/.config/hypr/hyprpaper-day.conf ~/.config/hypr/hyprpaper.conf
    killall hyprpaper && hyprpaper & disown
    echo "day" > ~/.config/waybar/current-theme
else
    # Switch to night
    cp ~/.config/waybar/style-night.css ~/.config/waybar/style.css
    gsettings set org.gnome.desktop.interface gtk-theme "Orchis-Purple-Dark"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    # Remove existing symlinks and copy night theme gtk4 files
    rm ~/.config/gtk-4.0/gtk.css
    rm ~/.config/gtk-4.0/gtk-dark.css
    rm -r ~/.config/gtk-4.0/assets
    cp /usr/share/themes/Orchis-Purple-Dark/gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css
    cp /usr/share/themes/Orchis-Purple-Dark/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css
    cp -r /usr/share/themes/Orchis-Purple-Dark/gtk-4.0/assets ~/.config/gtk-4.0/
    ln -sf ~/.config/rofi/theme-night.rasi ~/.config/rofi/theme.rasi
    ln -sf ~/.config/swaync/style-night.css ~/.config/swaync/style.css
    swaync-client --reload-css
    kitten themes Adwaita dark
	cp ~/.config/hypr/windowlooknight.lua ~/.config/hypr/windowlook.lua
    cp ~/.config/hypr/hyprpaper-night.conf ~/.config/hypr/hyprpaper.conf
    killall hyprpaper && hyprpaper & disown
    echo "night" > ~/.config/waybar/current-theme
fi

# Restart waybar to apply new style
killall waybar && waybar & disown
