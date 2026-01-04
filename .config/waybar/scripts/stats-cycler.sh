#!/usr/bin/env bash

# A script to cycle through system stats for Waybar

STATE_FILE="/tmp/waybar_stats_cycler_state"
if ! [ -f "$STATE_FILE" ]; then
  echo "0" > "$STATE_FILE"
fi

CURRENT_STATE=$(cat "$STATE_FILE")

get_cpu() {
  USAGE=$(top -bn1 2>/dev/null | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
  LOAD_AVG=$(cat /proc/loadavg 2>/dev/null | awk '{print $1", "$2", "$3}')
  if [ -z "$USAGE" ]; then USAGE="N/A"; fi
  if [ -z "$LOAD_AVG" ]; then LOAD_AVG="N/A"; fi
  printf '{"text": " %.0f%%", "tooltip": "CPU: %s%% | Load: %s"}\n' "$USAGE" "$USAGE" "$LOAD_AVG"
}

get_mem() {
  MEM_USED_MB=$(free -m | awk 'NR==2{print $3}')
  MEM_TOTAL_MB=$(free -m | awk 'NR==2{print $2}')
  if [ -z "$MEM_USED_MB" ] || [ -z "$MEM_TOTAL_MB" ] || [ "$MEM_TOTAL_MB" -eq 0 ]; then
    printf '{"text": " N/A", "tooltip": "Memory: N/A"}\n'
    return
  fi
  MEM_PERCENT=$(awk "BEGIN {printf \"%.0f\", ($MEM_USED_MB / $MEM_TOTAL_MB) * 100}")
  MEM_USED_GB=$(awk "BEGIN {printf \"%.1f\", $MEM_USED_MB/1024}")
  MEM_TOTAL_GB=$(awk "BEGIN {printf \"%.1f\", $MEM_TOTAL_MB/1024}")
  printf '{"text": " %s%%", "tooltip": "Memory: %sG / %sG"}\n' "$MEM_PERCENT" "$MEM_USED_GB" "$MEM_TOTAL_GB"
}

get_net() {
  WIFI_SSID=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | grep "^yes" | cut -d: -f2)

  if [ -n "$WIFI_SSID" ]; then
    IP_ADDR=$(ip -4 addr show 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1' | head -n1)
    if [ -z "$IP_ADDR" ]; then IP_ADDR="N/A"; fi
    printf '{"text": " %s", "tooltip": "Wi-Fi: %s | IP: %s"}\n' "$WIFI_SSID" "$WIFI_SSID" "$IP_ADDR"
  else
    ETH_NAME=$(ip -o link show 2>/dev/null | awk -F': ' '$2 !~ /lo|vir|wl|docker|br|veth/ && /state UP/ {print $2}' | head -n1)
    if [ -n "$ETH_NAME" ]; then
      IP_ADDR=$(ip -4 addr show dev "$ETH_NAME" 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n1)
      if [ -z "$IP_ADDR" ]; then IP_ADDR="N/A"; fi
      printf '{"text": " %s", "tooltip": "Ethernet: %s | IP: %s"}\n' "$ETH_NAME" "$ETH_NAME" "$IP_ADDR"
    else
      printf '{"text": " Off", "tooltip": "No network connection"}\n'
    fi
  fi
}

case $CURRENT_STATE in
  0)
    get_cpu
    echo "1" > "$STATE_FILE"
    ;;
  1)
    get_mem
    echo "2" > "$STATE_FILE"
    ;;
  2)
    get_net
    echo "0" > "$STATE_FILE"
    ;;
  *)
    get_cpu # Default to CPU on error
    echo "1" > "$STATE_FILE"
    ;;
esac
