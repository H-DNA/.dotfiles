#!/bin/bash
# Simple WiFi menu using wofi and nmcli

current=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
status=$(nmcli radio wifi)

options="Connected: ${current:-None}
WiFi: $status
────────────
Scan Networks
Toggle WiFi
────────────"

# Get available networks
networks=$(nmcli -t -f ssid,signal,security dev wifi list | grep -v '^$' | head -10 | while IFS=: read -r ssid signal security; do
  [ -n "$ssid" ] && echo "$ssid ($signal% $security)"
done)

choice=$(echo -e "$options$networks" | wofi --dmenu --prompt "WiFi" --width 300 --height 400 --cache-file /dev/null)

case "$choice" in
  "Scan Networks") nmcli dev wifi rescan ;;
  "Toggle WiFi")
    if [ "$status" = "enabled" ]; then
      nmcli radio wifi off
    else
      nmcli radio wifi on
    fi
    ;;
  *"Connected:"*|*"WiFi:"*|*"──"*) ;; # ignore header lines
  *)
    # Extract SSID (everything before the parenthesis)
    ssid=$(echo "$choice" | sed 's/ ([^)]*$//')
    if [ -n "$ssid" ]; then
      nmcli dev wifi connect "$ssid" || \
      nmcli dev wifi connect "$ssid" --ask
    fi
    ;;
esac
