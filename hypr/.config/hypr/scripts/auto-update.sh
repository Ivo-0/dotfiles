#!/bin/bash

LOG="/var/log/auto-update.log"
export HOME=/home/ivo
export XDG_RUNTIME_DIR=/run/user/1000

# Clear previous log
> "$LOG"

# Check if on AC power - skip check if no power supply found (desktop)
power_supplies=$(ls /sys/class/power_supply/ 2>/dev/null)
if [ -n "$power_supplies" ]; then
    power=$(cat /sys/class/power_supply/*/online 2>/dev/null | grep -c "1")
    if [ "$power" -eq 0 ]; then
        echo "SKIPPED_POWER" > "$LOG"
        sudo -u ivo XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus systemctl --user start auto-update-notify.service
        exit 0
    fi
fi

# Check network
wifi=$(nmcli -t -f NAME connection show --active | grep "DrWho?")
ethernet=$(nmcli -t -f TYPE connection show --active | grep "ethernet")

echo "WiFi: $wifi" >> /var/log/auto-update.log
echo "Ethernet: $ethernet" >> /var/log/auto-update.log
echo "Power supplies: $power_supplies" >> /var/log/auto-update.log

if [ -z "$wifi" ] && [ -z "$ethernet" ]; then
    echo "SKIPPED_NETWORK" > "$LOG"
    sudo -u ivo XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus systemctl --user start auto-update-notify.service
    exit 0
fi

echo "STARTED" > "$LOG"

# Update official repo packages as root
if ! pacman -Syu --noconfirm 2>&1; then
    echo "FAILED_PACMAN" >> "$LOG"
fi

# Get list of AUR packages needing updates
aur_packages=$(sudo -u ivo yay -Qu --aur --noconfirm 2>/dev/null | awk '{print $1}')

# Update each AUR package individually
for package in $aur_packages; do
    if ! sudo -u ivo yay -S "$package" \
        --noconfirm \
        --removemake \
        --norebuild 2>&1; then
        echo "FAILED_PKG:$package" >> "$LOG"
    fi
done

echo "COMPLETE" >> "$LOG"
# Get DBus address dynamically from waybar process
DBUS=$(cat /proc/$(pgrep -u ivo waybar)/environ 2>/dev/null | tr '\0' '\n' | grep DBUS_SESSION_BUS_ADDRESS | cut -d= -f2-)
sudo -u ivo XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus systemctl --user start auto-update-notify.service
