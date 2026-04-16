#!/bin/bash

# Count available updates
pacman_updates=$(checkupdates 2>/dev/null | wc -l)
aur_updates=$(yay -Qua 2>/dev/null | wc -l)
total=$((pacman_updates + aur_updates))

if [ "$total" -eq 0 ]; then
    echo "{\"text\": \" 0\", \"tooltip\": \"System up to date!\", \"class\": \"updated\"}"
else
    echo "{\"text\": \" $total\", \"tooltip\": \"$pacman_updates pacman updates\n$aur_updates AUR updates\", \"class\": \"outdated\"}"
fi
