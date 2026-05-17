# Dotfiles

Personal configurations for my Hyprland environment on Arch Linux.

![demo](assets/demo.gif)

## 🖥️ Setup

| | |
|---|---|
| **OS** | Arch Linux |
| **WM** | Hyprland |
| **Bar** | Waybar |
| **Terminal** | Kitty |
| **Launcher** | Rofi |
| **Notifications** | Swaync |
| **Shell** | Zsh + Starship |
| **Wallpaper** | Hyprpaper |

## 📁 Structure

```text
dotfiles/
├── config/
│   ├── hypr/        # Hyprland, hyprlock, hyprpaper, hypridle
│   ├── waybar/      # Status bar
│   └── kitty/       # Terminal
├── assets/
│   └── wallpapers.md
├── install.sh
└── README.md
```

## Installation

```bash
git clone https://github.com/rmlho/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## Dependencies

```bash
sudo pacman -S hyprland waybar kitty rofi dunst swaync \
               hyprlock hypridle hyprpaper swayosd wlogout \
               starship zsh
```
