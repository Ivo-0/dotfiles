#!/bin/bash

# ── Configuration ────────────────────────────────
APP_CMD="blueman-manager"           # Command to launch the app
APP_TITLE="blueman-manager"         # Window title (set with --title if using kitty)
WORKSPACE="bluetooth"         # Special workspace name
TOGGLE_FILE="/tmp/$WORKSPACE-open"
# ─────────────────────────────────────────────────

if [ -f "$TOGGLE_FILE" ]; then
    rm "$TOGGLE_FILE"
    pkill -f "$APP_CMD"
else
    touch "$TOGGLE_FILE"
    $APP_CMD &
fi