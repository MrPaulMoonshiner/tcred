#!/bin/zsh

FILE="$HOME/tcred/counter/storage"

DATE=$(date +"%Y-%m-%d")

typeset -A run_counts

read_data() {
    if [ -f "$FILE" ]; then
        while IFS="=" read -r key value; do
            run_counts["$key"]=$value
        done < "$FILE"
    else
        touch "$FILE"
    fi
}

write_data() {
    > "$FILE"
    for key in ${(k)run_counts}; do
        echo "$key=${run_counts[$key]}" >> "$FILE"
    done
}

read_data

if [[ -n "${run_counts[$DATE]}" ]]; then
    run_counts[$DATE]=$((run_counts[$DATE] + 1))
else
    run_counts[$DATE]=1
fi

write_data