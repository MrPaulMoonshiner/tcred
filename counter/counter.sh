#!/bin/bash

DATA_FILE="$HOME/tcred/counter/storage"
current_date=$(date +%F)

declare -A usage_data

if [[ -f $DATA_FILE ]]; then
    while IFS="=" read -r key value; do
        usage_data["$key"]=$value
    done < "$DATA_FILE"
fi

if [[ -n "${usage_data[$current_date]}" ]]; then
    usage_data["$current_date"]=$((usage_data["$current_date"] + 1))
else
    usage_data["$current_date"]=1
fi

{
    for key in "${!usage_data[@]}"; do
        echo "$key=${usage_data[$key]}"
    done
} > "$DATA_FILE"
