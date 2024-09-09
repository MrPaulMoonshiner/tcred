#!/bin/bash
TCRED_STORAGE_DIR="$HOME/tcred/storage"
DATA_STORAGE_FILE="$TCRED_STORAGE_DIR/data_storage"
KEY_VALUE_STORAGE_FILE="$TCRED_STORAGE_DIR/key_value_storage"

import_from_csv() {
    local csv_file=$1

    if [[ ! -f $csv_file ]]; then
        echo "CSV file not found!"
        exit 1
    fi

    declare -A url_alias_host
    declare -A url_alias_market
    declare -A url_aliases

    while IFS=';' read -r id uuid url name; do
        url_alias_host["$id"]="$url"
        url_alias_market["$id"]="$(echo "$name" | tr -d '\r\n')"
        url_aliases["$id"]="$uuid"
    done < "$csv_file"

    save_arrays_to_files 
}

save_arrays_to_files() {
    echo "#!/bin/bash" > $DATA_STORAGE_FILE
    echo "" >> $DATA_STORAGE_FILE
    echo "declare -A url_alias_host=(" >> $DATA_STORAGE_FILE
    for id in "${!url_alias_host[@]}"; do
        echo "  ["$id"]=\"${url_alias_host[$id]}\"" >> $DATA_STORAGE_FILE
    done
    echo ")" >> $DATA_STORAGE_FILE
    echo "" >> $DATA_STORAGE_FILE
    echo "declare -A url_alias_market=(" >> $DATA_STORAGE_FILE
    for id in "${!url_alias_market[@]}"; do
        echo "  ["$id"]=\"${url_alias_market[$id]}\"" >> $DATA_STORAGE_FILE
    done
    echo ")" >> $DATA_STORAGE_FILE

    echo "#!/bin/bash" > $KEY_VALUE_STORAGE_FILE
    echo "" >> $KEY_VALUE_STORAGE_FILE
    echo "declare -A url_aliases=(" >> $KEY_VALUE_STORAGE_FILE
    for id in "${!url_aliases[@]}"; do
        echo "  ["$id"]=\"${url_aliases[$id]}\"" >> $KEY_VALUE_STORAGE_FILE
    done
    echo ")" >> $KEY_VALUE_STORAGE_FILE
}
