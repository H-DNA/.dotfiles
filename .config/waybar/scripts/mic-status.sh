#!/usr/bin/env bash

# Microphone mute status for waybar

muted=$(pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | grep -c "yes")

if [ "$muted" -eq 1 ]; then
    echo "{\"text\": \"󰍭\", \"tooltip\": \"Microphone muted - Click to unmute\", \"class\": \"muted\"}"
else
    echo "{\"text\": \"󰍬\", \"tooltip\": \"Microphone active - Click to mute\", \"class\": \"active\"}"
fi
