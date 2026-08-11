#!/bin/bash

PERCENTAGE=$(pmset -g batt | grep -o "[0-9]\{1,3\}%" | sed "s/%//")
CHARGING=$(pmset -g batt | grep 'AC Power')

if [[ $CHARGING != "" ]]; then
  ICON=""
  COLOR="0xff33ff33"
else
  case ${PERCENTAGE} in
    9[0-9]|100) ICON="" ; COLOR="0xff00ff00" ;;
    [6-8][0-9]) ICON="" ; COLOR="0xff00ff00" ;;
    [3-5][0-9]) ICON="" ; COLOR="0xff00ff00" ;;
    [1-2][0-9]) ICON="" ; COLOR="0xffff0000" ;;
    *) ICON="" ; COLOR="0xffEF476F" ;;
  esac
fi
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" background.color="$COLOR"
