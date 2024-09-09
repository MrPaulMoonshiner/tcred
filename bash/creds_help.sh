#!/bin/bash
TCRED_STORAGE_DIR="$HOME/tcred/storage"
source $TCRED_STORAGE_DIR/data_storage
source $TCRED_STORAGE_DIR/key_value_storage

# Function to display help
show_help() {
    echo "Usage: tcred --hepl <url_alias> --print [env: default:live |uat |<multidev_name>] [action: default:uli |cr |etc] [util: default:drush]"
    echo
    echo "Result: terminus [util] <url_alias>.[env] [action]"
    echo
    echo "Note: only <url_alias> is required."
    echo
    echo "Using by default is: tcred bg  -> termins drush 72325-food-maggi-bulgaria.live uli"
    echo
    echo "Using with all values is: tcred bg live uli drush -> termins drush 72325-food-maggi-bulgaria.live uli"
    echo
    echo "Using by SRH drush command: tcred lk live srh-sync-recipes -> terminus drush 72506-food-maggi-srilanka.live srh-sync-recipes"
    echo
    echo "Using by only print mode: tcread lk --print -> return string: 'Command to print: terminus drush 72506-food-maggi-srilanka.live uli'"
    echo
    echo "For importing data from csv file use -i or --import flag and path to file.csv"
    echo
    echo "URL Aliases:"

   
local max_id_length=2
local max_uuid_length=4
local max_name_length=4
local max_url_length=3

for key in "${!url_alias_host[@]}"; do
    (( ${#key} > max_id_length )) && max_id_length=${#key}
    (( ${#url_aliases[$key]} > max_uuid_length )) && max_uuid_length=${#url_aliases[$key]}
    (( ${#url_alias_market[$key]} > max_name_length )) && max_name_length=${#url_alias_market[$key]}
    (( ${#url_alias_host[$key]} > max_url_length )) && max_url_length=${#url_alias_host[$key]}
done

# Print the header
printf "%-${max_id_length}s | %-${max_uuid_length}s | %-${max_name_length}s | %-${max_url_length}s\n" "ID" "UUID" "URL" "Market name"
printf "%-${max_id_length}s-+-%-${max_uuid_length}s-+-%-${max_name_length}s-+-%-${max_url_length}s\n" "$(printf '%0.s-' $(seq 1 $max_id_length))" "$(printf '%0.s-' $(seq 1 $max_uuid_length))" "$(printf '%0.s-' $(seq 1 $max_name_length))" "$(printf '%0.s-' $(seq 1 $max_url_length))|"

# Print the data
for key in "${!url_alias_host[@]}"; do
    printf "%-${max_id_length}s | %-${max_uuid_length}s | %-${max_name_length}s | %-${max_url_length}s\n" "$key" "${url_aliases[$key]}" "${url_alias_market[$key]}" "${url_alias_host[$key]}"
    printf "%-${max_id_length}s-+-%-${max_uuid_length}s-+-%-${max_name_length}s-+-%-${max_url_length}s\n" "$(printf '%0.s-' $(seq 1 $max_id_length))" "$(printf '%0.s-' $(seq 1 $max_uuid_length))" "$(printf '%0.s-' $(seq 1 $max_name_length))" "$(printf '%0.s-' $(seq 1 $max_url_length))|"
done

}
 
 show_help