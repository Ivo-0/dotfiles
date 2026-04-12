#!/bin/bash
capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)
profile=$(powerprofilesctl get)

# Choose icon based on status and capacity
if [ "$status" = "Charging" ]; then
    if [ "$capacity" -lt 34 ]; then
        icon="󱊤"
    elif [ "$capacity" -lt 67 ]; then
        icon="󱊥"
    else
        icon="󱊦"
    fi
else
    if [ "$capacity" -lt 34 ]; then
        icon="󱊡"
    elif [ "$capacity" -lt 67 ]; then
        icon="󱊢"
    else
        icon="󱊣"
    fi
fi

echo "{\"text\": \"$icon $capacity%\", \"tooltip\": \"Power profile: $profile\"}"
