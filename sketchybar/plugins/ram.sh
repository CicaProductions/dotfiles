#!/bin/bash

# Get raw memory statistics in pages from vm_stat using grep for consistency
pages_free=$(vm_stat | grep "Pages free:" | awk '{print $NF}' | tr -d '.')
pages_active=$(vm_stat | grep "Pages active:" | awk '{print $NF}' | tr -d '.')
pages_inactive=$(vm_stat | grep "Pages inactive:" | awk '{print $NF}' | tr -d '.')
pages_wired=$(vm_stat | grep "Pages wired down:" | awk '{print $NF}' | tr -d '.')

# Calculate total and used memory in pages
pages_total=$((pages_free + pages_active + pages_inactive + pages_wired))
pages_used=$((pages_active + pages_inactive + pages_wired))

# Check for a zero denominator to prevent division by zero errors
if [[ "$pages_total" -eq 0 ]]; then
  ram_percent=0
else
  ram_percent=$((pages_used * 100 / pages_total))
fi
echo $ram_percent
# Output to sketchybar
sketchybar --set $NAME label="$ram_percent%"
#!/bin/bash

# Use grep to find the percentage value in the output of memory_pressure.
# The -E flag enables extended regex, and -o outputs only the match.
ram_pressure=$(memory_pressure | grep -Eo '[0-9]+%')

# Send the output to sketchybar
sketchybar --set $NAME label="$ram_pressure"