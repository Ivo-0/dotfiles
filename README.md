Install Steps - I've never ran this but I think I corrected any errors claude made haha
Always use don't cleanbuild, and don't do the other one, and remove make dependencies in yay
## Dependencies

### Official repos
```bash
sudo pacman -S yay hyprland waybar hyprpaper hyprlock hypridle hyprshot rofi-wayland clipse wl-clipboard brightnessctl blueman pavucontrol gnome-calendar gnome-calculator nwg-displays nwg-look qt5ct qt6ct papirus-icon-theme ttf-jetbrains-mono-nerd stow git swaync btop network-manager-applet pacman-contrib polkit-gnome
```

### AUR packages
```bash
yay -S clipse orchis-theme mission-center-git james-dsp filen-desktop-bin
```

> During mission-center-git installation, select the CachyOS repo variant of rust when prompted.

---

## Services

Enable the following services after installation:

```bash
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable power-profiles-daemon
```

---

## Installation

### 1. Install dependencies
Install all packages listed above before proceeding.
Run nwg-look and nwg-display to allow them to create their own configs - will cause errors if not done. These programs can be immedately closed.

### 2. Install themes
Download Orchis-Purple.tar.xz from https://www.gnome-look.org/p/1357889
To install run

```bash
xz -d ~/Downloads/Orchis-Purple.tar.xz
tar -xf ~/Downloads/Orchis-Purple.tar
sudo cp -r ~/Orchis-Purple-Dark /usr/share/themes 
sudo cp -r ~/Orchis-Purple-Light /usr/share/themes 
rm -r ~/Orchis-Purple
rm -r ~/Orchis-Purple-Compact
rm -r ~/Orchis-Purple-Dark
rm -r ~/Orchis-Purple-Dark-Compact
rm -r ~/Orchis-Purple-Light
rm -r ~/Orchis-Purple-Light-Compact
```

### 3. Set up SSH key for GitHub (recommended)
```bash
ssh-keygen -t ed25519 -C "youremail@example.com"
eval (ssh-agent -c)
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```
Copy the output and add it to your GitHub account under **Settings → SSH and GPG keys → New SSH key**.

Test the connection:
```bash
ssh -T git@github.com
```

### 4. Clone the repository
```bash
git clone git@github.com:Ivo-0/dotfiles.git ~/dotfiles
```

### 5. Configure git identity
```bash
git config --global user.email "youremail@example.com"
git config --global user.name "Your Name"
```

### 6. Create config directories
```bash
mkdir -p ~/.config/hypr/scripts
mkdir -p ~/.config/waybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/swaync
mkdir -p ~/.config/gtk-4.0
```

### 7. Remove any existing default configs
CachyOS may place default configs in these locations on a fresh install. Remove them before running Stow:
```bash
rm -f ~/.config/hypr/hyprland.conf
rm -f ~/.config/waybar/config.jsonc
rm -f ~/.config/waybar/style.css
```

### 8. Symlink configs with Stow
Run the following from inside the dotfiles directory:
```bash
cd ~/dotfiles
stow hypr
stow waybar
stow rofi
stow swaync
stow hyprlock
stow hypridle
```

If Stow throws a conflict error, remove the conflicting file from `~/.config/` and run the stow command again.

### 9. Make scripts executable
```bash
chmod +x ~/.config/hypr/scripts/*.sh
```

### 9. Set up polkit authentication agent
Polkit-gnome is used as the authentication agent. It is launched automatically via exec-once in hyprland.conf — no additional setup required.

### 10. Reload Hyprland
```bash
hyprctl reload
```

---

## Updating

### Push changes to GitHub
```bash
cd ~/dotfiles
git status
git add .
git commit -m "describe your changes"
git push
```

### Pull changes on another machine
```bash
cd ~/dotfiles
git pull
```

> After pulling, restart Waybar to apply any style changes:
> ```bash
> killall waybar && waybar & disown
> ```

---

## Notes

- **JetBrains Mono Nerd Font** is required for Waybar icons to display correctly
- **Orchis-Puple** is the GTK theme used
- If waybar bugs out when cycling day/night theme it just won't boot, can run waybar in the terminal to see where its failing
- nwg-look is functional, though the day/night theme cycle will override anything done, permanent changes need to be made in ~/.config/hypr/scripts/toggle-theme.sh

---

## Keybinds

| Keybind | Action |
|---|---|
| Super + Return | Open terminal |
| Super + Ctrl + Return | Open Rofi launcher |
| Super + Q | Close window |
| Super + V | Open Clipse clipboard |
| Super + N | Open Swaync notification centre |
| Super + Shift + N | Clear all notifications |
| Super + L | Lock screen |
| Super + B | Toggle blur on focused window |
| Print | Screenshot entire screen |
| Super + Print | Screenshot active window |
| Super + Shift + Print | Screenshot region |
| Super + 1-9 | Switch to workspace |
| Super + Shift + 1-9 | Move window to workspace |
| Super + mouse left | Move floating window |
| Super + mouse right | Resize floating window |

## Waybar Functions

- Inactive/active button in top left - INACTIVE will allow the computer to auto lock, and then sleep, ACTIVE will disable this
- Day/Night symbol toggles themes
- Blue/Orange tux penguin shows all package updates available in both pacman and yay, clicking will run the updater
- Clicking the clock will open a calendar
- Battery icon will still show on desktop, pressing this will cycle the power profile between performance, balanced, and powersaver, hover to see current profile. This does not automatically change with battery percentage
- Audio icon will open audio settings, can use this to select device. Don't select James DSP as audio output this is automatically routed.
- Wifi icon will open network settings, new connections can't be made here and should be made using network in the hidden applications tab (far right). Looks like two computers or a little wifi symbol.
- BT will open bluetooth settings.
- Power button opens shutdown/restart/sleep functions - suspend saves to ram while hibernate saves to disk - suspend is faster but uses more power.
