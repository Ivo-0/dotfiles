#!/bin/bash

LOG="/var/log/auto-update.log"

if [ ! -f "$LOG" ]; then
    notify-send "Auto Update" "No update log found" -i dialog-error
    exit 1
fi

# Read log and send appropriate notifications
while IFS= read -r line; do
    case "$line" in
        "SKIPPED_POWER")
            notify-send "Auto Update" "Skipped — not connected to power" -i system-software-update
            ;;
        "SKIPPED_NETWORK")
            notify-send "Auto Update" "Skipped — not on home network" -i network-wireless
            ;;
        "STARTED")
            notify-send "Auto Update" "System update completed" -i system-software-update
            ;;
        "FAILED_PACMAN")
            notify-send "Auto Update" "Pacman update failed — check logs" -i dialog-error
            ;;
        FAILED_PKG:*)
            package="${line#FAILED_PKG:}"
            notify-send "Auto Update" "Failed to update: $package" -i dialog-error
            ;;
        "COMPLETE")
            notify-send "Auto Update" "All updates finished!" -i system-software-update
            ;;
    esac
done < "$LOG"
