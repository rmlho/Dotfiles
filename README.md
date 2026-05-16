# 🏠 dotfiles

Configurações pessoais do meu ambiente Hyprland no CachyOS.

## 🖥️ Setup

| | |
|---|---|
| **OS** | Arch Linux |
| **WM** | Hyprland |
| **Bar** | Waybar |
| **Terminal** | Kitty |
| **Launcher** | Rofi |
| **Notificações** | Swaync |
| **Shell** | Zsh + Starship |
| **Wallpaper** | Hyprpaper |

## 📁 Estrutura

dotfiles/
├── config/
│   ├── hypr/        # Hyprland, hyprlock, hyprpaper, hypridle
│   ├── waybar/      # Barra de status
│   └── kitty/       # Terminal
├── assets/
│   └── wallpapers.md
├── install.sh
└── README.md

## 🚀 Instalação

```bash
git clone https://github.com/rmlho/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## ⚠️ Dependências

```bash
sudo pacman -S hyprland waybar kitty rofi dunst swaync \
               hyprlock hypridle hyprpaper swayosd wlogout \
               starship zsh
```
