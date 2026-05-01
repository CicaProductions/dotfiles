#!/bin/bash

BLUEUTIL=$(blueutil)

sketchybar --set $NAME drawing=on

if [[ $(blueutil -p) == "0" ]]; then
  # Bluetooth is on
  if [[ $(blueutil --is-connected) == "1" ]]; then
    ICON="󰂱" # Connected icon
    COLOR="0xff2ed829"
  else
    ICON="󰂲" # On but not connected icon
    COLOR="0xff81a1c1"
  fi
else
  # Bluetooth is off
  ICON="󰂯" # Off icon
  COLOR="0xff65737e"
fi

sketchybar --set $NAME icon="$ICON" background.color="$COLOR"
