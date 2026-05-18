#!/bin/bash
VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d", $2*100}')

eww open volume-osd
eww update volume=$VOL

pkill -f "volume-osd-timer" 2>/dev/null
(sleep 2 && eww close volume-osd) &
