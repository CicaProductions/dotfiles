#!/bin/bash

target=$1

# Keep creating spaces until we have at least $target spaces
while [ $(yabai -m query --spaces | jq 'length') -lt $target ]; do
  yabai -m space --create
done

# Focus the target space
yabai -m space --focus $target