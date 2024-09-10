#!/bin/bash

LOG_FILE="$HOME/tcred/counter/storage"

print_launch_data() {
    local total_launches=0
    echo "date       | count"
    echo "----------------------"
    for key in "${!launch_data[@]}"; do
        printf "%s | %s\n" "$key" "${launch_data[$key]}"
        ((total_launches+=${launch_data[$key]}))
    done
    echo "----------------------"
    echo "General count: $total_launches"
}

if [ -f "$LOG_FILE" ]; then
    declare -A launch_data
    source "$LOG_FILE"
    print_launch_data
    exit 0;
else
    echo "Tcred logs not found"
    exit 0;
fi