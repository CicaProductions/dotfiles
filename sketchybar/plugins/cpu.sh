#!/bin/bash

# Get number of cores on macOS
cores=$(sysctl -n hw.ncpu)

# Sum CPU usage of all processes and divide by number of cores
cpu_usage=$(ps -A -o %cpu | awk -v cores="$cores" '{s+=$1} END {printf "%.0f", s/cores}')

# Send the output to sketchybar
sketchybar --set cpu_percent label="$cpu_usage%"
