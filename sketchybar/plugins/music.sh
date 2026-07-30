#!/bin/bash

PLAYER="Spotify"

if pgrep -x "$PLAYER" >/dev/null; then
  STATUS=$(osascript -e 'tell application "Spotify" to get player state' 2>/dev/null)

  if [ "$STATUS" = "playing" ] || [ "$STATUS" = "paused" ]; then
    ARTIST=$(osascript -e 'tell application "Spotify" to get artist of current track' 2>/dev/null)
    SONG=$(osascript -e 'tell application "Spotify" to get name of current track' 2>/dev/null)
    VOLUME=$(osascript -e 'tell application "Spotify" to get sound volume' 2>/dev/null)

    OUTPUT="$SONG - $VOLUME%"
  else
    OUTPUT="No song playing"
  fi
else
  OUTPUT="Spotify closed"
fi

sketchybar --set "$NAME" label="$OUTPUT"
