#!/bin/bash
cliphist list | rofi -dmenu -theme ~/.config/rofi/gruvbox.rasi -theme-str 'window {width: 700px;}' | cliphist decode | wl-copy
