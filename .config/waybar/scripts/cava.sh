#!/bin/bash

# Define the bar characters
# Range 0-7 from CAVA
bar=" ▂▃▄▅▆▇█"

# Ensure CAVA is killed when the script stops
trap "pkill -P $$" EXIT

# Execute cava in the background and read its output byte by byte
# cava in 'program' data_format outputs integers (0-7)
cava -p ~/.config/cava/config | while IFS= read -r -n1 char; do
    if [ -n "$char" ]; then
        # Get the numeric value of the character (0-7)
        # Using printf to get the ASCII value of the byte
        val=$(printf '%d' "'$char")
        
        # Select the corresponding bar character (multiplying by 3 because UTF-8 chars are 3 bytes)
        # However, a simpler way is string indexing:
        echo -n "${bar:$val:1}"
        
        # We need to manage the number of bars (24 per line based on your config)
        ((count++))
        if [ "$count" -eq 24 ]; then
            echo ""
            count=0
        fi
    fi
done
