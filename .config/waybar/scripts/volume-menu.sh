#!/bin/bash
# Simple volume menu using wofi

current=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)
muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP 'yes|no')

options="Volume: $current
────────────
  100%
  75%
  50%
  25%
  0%
────────────
Toggle Mute (currently: $muted)"

choice=$(echo -e "$options" | wofi --dmenu --prompt "Volume" --width 200 --height 280 --cache-file /dev/null)

case "$choice" in
  *100%*) pactl set-sink-volume @DEFAULT_SINK@ 100% ;;
  *75%*) pactl set-sink-volume @DEFAULT_SINK@ 75% ;;
  *50%*) pactl set-sink-volume @DEFAULT_SINK@ 50% ;;
  *25%*) pactl set-sink-volume @DEFAULT_SINK@ 25% ;;
  *0%*) pactl set-sink-volume @DEFAULT_SINK@ 0% ;;
  *"Toggle Mute"*) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
esac
