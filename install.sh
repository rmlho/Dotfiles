#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

log()    { echo -e "${GREEN}  ✓${NC} $1"; }
warn()   { echo -e "${YELLOW}  !${NC} $1"; }
error()  { echo -e "${RED}  ✗${NC} $1"; }
info()   { echo -e "${BLUE}  →${NC} $1"; }

linked=()

link() {
    local src="$1"
    local dst="$2"
    local name="$3"

    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        warn "Backup: $dst → $dst.bak"
        mv "$dst" "$dst.bak"
    fi

    if [ -L "$dst" ]; then
        rm "$dst"
    fi

    ln -s "$src" "$dst"
    linked+=("$name")
    log "$name"
}

clear

echo ""
echo -e "${BOLD}  ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗${NC}"
echo -e "${BOLD}  ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝${NC}"
echo -e "${BOLD}  ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗${NC}"
echo -e "${BOLD}  ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║${NC}"
echo -e "${BOLD}  ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║${NC}"
echo -e "${BOLD}  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝${NC}"
echo ""
echo -e "  ${BLUE}by neo${NC} · Arch Linux · Hyprland"
echo ""
echo -e "  ${BOLD}Dotfiles:${NC} $DOTFILES_DIR"
echo -e "  ${BOLD}Config:${NC}   $CONFIG_DIR"
echo ""
echo -e "  ────────────────────────────────────────"
echo -e "  Criando symlinks..."
echo -e "  ────────────────────────────────────────"
echo ""

link "$DOTFILES_DIR/config/hypr"    "$CONFIG_DIR/hypr"    "hypr"
link "$DOTFILES_DIR/config/waybar"  "$CONFIG_DIR/waybar"  "waybar"
link "$DOTFILES_DIR/config/kitty"   "$CONFIG_DIR/kitty"   "kitty"

echo ""
echo -e "  ────────────────────────────────────────"
echo -e "  ${BOLD}Resumo${NC}"
echo -e "  ────────────────────────────────────────"
echo ""

for item in "${linked[@]}"; do
    info "$item → $CONFIG_DIR/$item"
done

echo ""
warn "Wallpapers não incluídos — veja assets/wallpapers.md"
echo ""
log "Pronto!"
echo ""
