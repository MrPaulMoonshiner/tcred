#!/bin/zsh

TCRED_STORAGE_DIR="$HOME/tcred/storage"
source $TCRED_STORAGE_DIR/key_value_storage

terminus_export() {
    local util='backup:get'
    local url=${url_aliases[$2]}
    local env=$3
    local flag_path="--to=$(eval echo $4)"
    local flag_element="--element=$5"
    echo "Current PATH: $PATH"
    which terminus
    echo "Command to run: terminus $util $url.$env $flag_element $flag_path"
    terminus "$util" "$url.$env" "$flag_element" "$flag_path"

}

terminus_export "$1" "$2" "$3" "$4" "$5"