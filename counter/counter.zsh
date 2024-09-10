#!/bin/zsh

LOG_FILE="$HOME/tcred/counter/storage"

CURRENT_DATE=$(date +"%Y-%m-%d")

if [ -f "$LOG_FILE" ]; then
    declare -A launch_data
    source "$LOG_FILE"

    if [[ -n "${launch_data[$CURRENT_DATE]}" ]]; then
        ((launch_data[$CURRENT_DATE]++))
    else
        launch_data[$CURRENT_DATE]=1
    fi
else
    declare -A launch_data
    launch_data[$CURRENT_DATE]=1
fi

echo "declare -A launch_data=(" > "$LOG_FILE"
for key value in ${(kv)launch_data}; do
    echo "  [$key]=$value" >> "$LOG_FILE"
done
echo ")" >> "$LOG_FILE"