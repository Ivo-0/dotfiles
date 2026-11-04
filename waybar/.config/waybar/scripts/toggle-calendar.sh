#!/bin/bash

# ── Configuration ────────────────────────────────
APP_CMD="gnome-calendar"           # Command to launch the app
APP_TITLE="org.gnome.calendar"         # Window title (set with --title if using kitty)
WORKSPACE="calendar"         # Special workspace name
TOGGLE_FILE="/tmp/$WORKSPACE-open"
# ─────────────────────────────────────────────────

if [ -f "$TOGGLE_FILE" ]; then
    rm "$TOGGLE_FILE"
    pkill -f "$APP_CMD"
else
    touch "$TOGGLE_FILE"
    $APP_CMD &
    sleep 0.3
    hyprctl eval 'hl.dispatch(hl.dsp.workspace.toggle_special("'"$WORKSPACE"'"))'
fi