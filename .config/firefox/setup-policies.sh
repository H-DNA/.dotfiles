#!/usr/bin/env bash

# Setup Firefox policies on any OS
# Run with sudo on Linux/macOS

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
POLICIES_FILE="$SCRIPT_DIR/policies.json"

case "$(uname -s)" in
    Linux)
        # Works on most Linux distros
        sudo mkdir -p /etc/firefox/policies
        sudo ln -sf "$POLICIES_FILE" /etc/firefox/policies/policies.json
        echo "Linked to /etc/firefox/policies/policies.json"
        ;;
    Darwin)
        # macOS
        DIST_DIR="/Applications/Firefox.app/Contents/Resources/distribution"
        sudo mkdir -p "$DIST_DIR"
        sudo ln -sf "$POLICIES_FILE" "$DIST_DIR/policies.json"
        echo "Linked to $DIST_DIR/policies.json"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        # Windows (Git Bash)
        echo "On Windows, manually copy policies.json to:"
        echo "  C:\\Program Files\\Mozilla Firefox\\distribution\\policies.json"
        ;;
    *)
        echo "Unknown OS: $(uname -s)"
        exit 1
        ;;
esac

echo "Restart Firefox to apply bookmarks."
