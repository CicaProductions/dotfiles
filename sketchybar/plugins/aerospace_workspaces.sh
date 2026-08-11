#!/bin/bash

# Get the name of the currently focused workspace from AeroSpace
current_workspace=$(aerospace list-workspaces --focused)

# Set the label for the workspaces item in Sketchybar
sketchybar --set "$NAME" label="WS: $current_workspace"
