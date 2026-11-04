#!/bin/bash

# ── Configuration ────────────────────────────────
APP_CMD="pavucontrol"
APP_TITLE="org.pulseaudio.pavucontrol"
WORKSPACE="volume"
TOGGLE_FILE="/tmp/$WORKSPACE-open"
# ─────────────────────────────────────────────────

if [ -f "$TOGGLE_FILE" ]; then
    rm "$TOGGLE_FILE"
    pkill -x "$APP_CMD"
else
    touch "$TOGGLE_FILE"
    $APP_CMD &
fi