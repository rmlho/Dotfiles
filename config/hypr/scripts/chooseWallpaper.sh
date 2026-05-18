#!/usr/bin/env bash

BACKGROUNDS_DIR="$HOME/new-dotfiles/assets"
THUMB_DIR="$HOME/.cache/wall-thumbs"
mkdir -p "$THUMB_DIR"

get_wall_name() {
    local rofi_input=""

    while IFS= read -r file; do
        name="${file##*/}"
        thumb="$THUMB_DIR/$name"

        if [ ! -f "$thumb" ]; then
            magick "$file" -thumbnail 200x200^ -gravity center -extent 200x200 "$thumb" 2>/dev/null
        fi

        rofi_input+="$name\x00icon\x1f$thumb\n"
    done < <(find "$BACKGROUNDS_DIR" -maxdepth 1 -type f \( \
        -iname "*.jpg" -o -iname "*.jpeg" -o \
        -iname "*.png" -o -iname "*.gif" -o \
        -iname "*.bmp" -o -iname "*.webp" \
    \) | sort)

    selected_wall="$(printf '%b' "$rofi_input" | rofi -dmenu -i -p "Choose Wallpaper" -show-icons -theme ~/.config/rofi/gruvbox-wall.rasi)"
    [[ -z "$selected_wall" ]] && exit 1

    local positions=("center" "top" "bottom" "left" "right" "top-left" "top-right" "bottom-left" "bottom-right")
    local random_pos=${positions[$RANDOM % ${#positions[@]}]}

    awww init &>/dev/null || true
    awww img "$BACKGROUNDS_DIR/$selected_wall" \
        --transition-type grow \
        --transition-fps 60 \
        --transition-duration 2.0 \
        --transition-pos "$random_pos"

    notify-send "Theme Switcher" "Applied: $selected_wall"
}

get_wall_name
