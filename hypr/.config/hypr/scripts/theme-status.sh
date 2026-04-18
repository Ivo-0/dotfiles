#!/bin/bash
current=$(cat ~/.config/waybar/current-theme 2>/dev/null || echo "night")
if [ "$current" = "night" ]; then
    echo "{\"text\": \"\"}"
else
    echo "{\"text\": \" \"}"
fi
