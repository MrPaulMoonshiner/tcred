#!/bin/zsh

FILE="$HOME/tcred/counter/storage"

DATE=$(date +"%Y-%m-%d")

run_counts=""

read_data() {
    if [ -f "$FILE" ]; then
        run_counts=$(cat "$FILE")
    else
        touch "$FILE"
    fi
}

write_data() {
    echo "$run_counts" > "$FILE"
}

read_data

if echo "$run_counts" | grep -q "$DATE"; then
    run_counts=$(echo "$run_counts" | sed -E "s/($DATE=)([0-9]+)/echo \1$((\2 + 1))/e")
else
    run_counts="$run_counts\n$DATE=1"
fi

write_data