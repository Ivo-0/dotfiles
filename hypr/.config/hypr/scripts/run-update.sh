#!/bin/bash
kitty --class update -e sh -c "yay -Syu && echo 'Update complete! Press any key to close.' && read"
