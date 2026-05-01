
#!/bin/bash

PLAYER="Spotify"

RUNNING=$(osascript -e 'tell application "System Events" to (name of processes) contains "Spotify"')

if [ "$RUNNING" = "true" ]; then
  STATUS=$(osascript -e 'tell application "Spotify" to get player state')
  ARTIST=$(osascript -e 'tell application "Spotify" to get artist of current track')
  SONG=$(osascript -e 'tell application "Spotify" to get name of current track')
  VOLUME=$(osascript -e 'tell application "Spotify" to get sound volume')

  OUTPUT="$SONG - $VOLUME%"
else
  OUTPUT="No song playing"
fi

sketchybar --set "$NAME" label="$OUTPUT"
