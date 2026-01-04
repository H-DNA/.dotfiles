#!/usr/bin/env bash

# Recording status for waybar - shows stop/pause buttons when recording

RECORDING_PID_FILE="/tmp/wf-recorder.pid"
RECORDING_START_FILE="/tmp/wf-recorder-start"
RECORDING_AUDIO_FILE="/tmp/wf-recorder-audio"
RECORDING_PAUSED_FILE="/tmp/wf-recorder-paused"
RECORDING_SEGMENTS_DIR="/tmp/wf-recorder-segments"

# Check if recording is active or paused
is_active=false
if [ -f "$RECORDING_PID_FILE" ]; then
    pid=$(cat "$RECORDING_PID_FILE")
    kill -0 "$pid" 2>/dev/null && is_active=true
fi
# Video paused state (PID removed but segments exist)
[ -f "$RECORDING_PAUSED_FILE" ] && [ -d "$RECORDING_SEGMENTS_DIR" ] && is_active=true

if [ "$is_active" = true ]; then
    # Check if paused
    paused=""
    [ -f "$RECORDING_PAUSED_FILE" ] && paused="yes"

    # Calculate elapsed time (subtract paused time)
    if [ -f "$RECORDING_START_FILE" ]; then
        start=$(cat "$RECORDING_START_FILE")
        now=$(date +%s)
        total_paused=$(cat /tmp/wf-recorder-paused-total 2>/dev/null || echo 0)

        if [ -n "$paused" ]; then
            # Currently paused - freeze timer at pause moment
            pause_start=$(cat "$RECORDING_PAUSED_FILE")
            elapsed=$((pause_start - start - total_paused))
        else
            # Running - show live time minus total paused
            elapsed=$((now - start - total_paused))
        fi

        time=$(printf "%02d:%02d" $((elapsed / 60)) $((elapsed % 60)))
    else
        time="00:00"
    fi

    # Get audio status
    audio_mode="none"
    [ -f "$RECORDING_AUDIO_FILE" ] && audio_mode=$(cat "$RECORDING_AUDIO_FILE")

    # Build indicator based on audio mode
    case "$audio_mode" in
        voice-only)
            icons="󰍬"
            tooltip="Voice recording"
            ;;
        both)
            icons="󰑊 󰕾 󰍬"
            tooltip="Recording with system audio + mic"
            ;;
        audio)
            icons="󰑊 󰕾"
            tooltip="Recording with system audio"
            ;;
        voice)
            icons="󰑊 󰍬"
            tooltip="Recording with microphone"
            ;;
        *)
            icons="󰑊"
            tooltip="Recording (no audio)"
            ;;
    esac

    # Add pause indicator
    if [ -n "$paused" ]; then
        icons="󰏤 $icons"
        tooltip="$tooltip (PAUSED)"
        class="recording paused"
    else
        class="recording"
    fi

    # Output JSON for waybar
    echo "{\"text\": \"$icons $time\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
    exit 0
fi

# Not recording - output empty (hides module)
echo "{\"text\": \"\", \"tooltip\": \"\", \"class\": \"\"}"
