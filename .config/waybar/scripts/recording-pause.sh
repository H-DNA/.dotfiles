#!/usr/bin/env bash

# Pause button for waybar - shows for all recordings

RECORDING_PID_FILE="/tmp/wf-recorder.pid"
RECORDING_PAUSED_FILE="/tmp/wf-recorder-paused"
RECORDING_SEGMENTS_DIR="/tmp/wf-recorder-segments"

# Check if recording is active or paused
is_recording=false
if [ -f "$RECORDING_PID_FILE" ]; then
    pid=$(cat "$RECORDING_PID_FILE")
    kill -0 "$pid" 2>/dev/null && is_recording=true
fi

# Also check if paused (video removes PID when paused)
[ -f "$RECORDING_PAUSED_FILE" ] && [ -d "$RECORDING_SEGMENTS_DIR" ] && is_recording=true

if [ "$is_recording" = true ]; then
    if [ -f "$RECORDING_PAUSED_FILE" ]; then
        echo '{"text": "󰐌", "tooltip": "Resume recording", "class": "paused"}'
    else
        echo '{"text": "󰏤", "tooltip": "Pause recording", "class": "active"}'
    fi
    exit 0
fi

echo '{"text": "", "tooltip": "", "class": ""}'
