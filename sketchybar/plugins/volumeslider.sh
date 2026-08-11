#!/bin/bash

# Get the current Spotify volume using osascript
VOLUME=$(osascript -e 'tell application "Spotify" to get sound volume')

# Update the slider's percentage based on the volume
sketchybar --set "$NAME" slider.percentage="$VOLUME"