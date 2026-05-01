#!/bin/bash

tmpfile=$(mktemp /tmp/karabiner-nvim.XXXXXX)

# Read input into temp file
cat > "$tmpfile"

# Launch Alacritty and wait for it to close
alacritty -e nvim "$tmpfile"

# After nvim exits, output file contents
cat "$tmpfile"

rm "$tmpfile"
