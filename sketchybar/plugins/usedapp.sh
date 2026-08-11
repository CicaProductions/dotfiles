#!/bin/bash

# Get the name of the currently active application and its icon
APP_NAME=$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true')

sketchybar --set "$NAME" label="$APP_NAME"