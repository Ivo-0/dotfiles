#!/bin/bash
chosen=$(echo -e "⏻ Shutdown\n Restart\n Suspend\n Hibernate" | rofi -dmenu -p "Power Menu" -theme ~/.config/rofi/theme.rasi)

case "$chosen" in
    "⏻ Shutdown") systemctl poweroff ;;
    " Restart") systemctl reboot ;;
    " Suspend") systemctl suspend ;;
    " Hibernate") systemctl hibernate ;;
esac
