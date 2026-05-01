#!/bin/bash

# Find the application and its workspace
APP_INFO=$(aerospace list-windows --all --format "%s %w" | grep -i "Spotify")

# Check if the application was found
if [[ -n "$APP_INFO" ]]; then
    # Get the window ID and workspace number
    APP_WINDOW_ID=$(echo "$APP_INFO" | awk '{print $1}')
    APP_WORKSPACE=$(echo "$APP_INFO" | awk '{print $2}')

    # Swap to the workspace if it's not the current one
    CURRENT_WORKSPACE=$(aerospace list-workspaces --format "%s" --focused)

    if [[ "$APP_WORKSPACE" != "$CURRENT_WORKSPACE" ]]; then
        aerospace go-to-workspace "$APP_WORKSPACE"
    fi

    # Focus the application's window
    aerospace focus-window "$APP_WINDOW_ID"
else
    # Launch the application if it's not running
    open -a "Spotify"
fi