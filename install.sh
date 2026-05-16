#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log()    { echo -e "${GREEN}[✓]${NC} $1"; }
warn()   { echo -e "${YELLOW}[!]${NC} $1"; }
error()  { echo -e "${RED}[✗]${NC} $1"; }

link() {
    local src="$1"
    local dst="$2"

    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        warn "Backup de $dst → $dst.bak"
        mv "$dst" "$dst.bak"
    fi

    if [ -L "$dst" ]; then
        rm "$dst"
    fi

    ln -s "$src" "$dst"
    log "Linked: $dst → $src"
}

echo ""
echo "  Instalando dotfiles do neo..."
echo "  Dotfiles em: $DOTFILES_DIR"
echo ""

link "$DOTFILES_DIR/config/hypr"    "$CONFIG_DIR/hypr"
link "$DOTFILES_DIR/config/waybar"  "$CONFIG_DIR/waybar"
link "$DOTFILES_DIR/config/kitty"   "$CONFIG_DIR/kitty"

echo ""
warn "Wallpapers NÃO são incluídos no repositório."
warn "Veja assets/wallpapers.md para a lista completa."
warn "Coloque seus wallpapers em ~/Pictures/wallpapers/"
echo ""
log "Instalação concluída!"
