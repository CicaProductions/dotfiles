#!/bin/bash

target=$1

# Keep creating spaces until we have at least $target spaces
while [ $(yabai -m query --spaces | jq 'length') -lt $target ]; do
  yabai -m space --create
done

# Send window to target space
yabai -m window --space $target
