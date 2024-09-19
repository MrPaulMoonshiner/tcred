#!/bin/zsh

TCRED_STORAGE_DIR="$HOME/tcred/storage"
source $TCRED_STORAGE_DIR/key_value_storage

terminus_export() {

    if [[ -z ${url_aliases[$2]} ]]; then
        echo "Error: Unknown URL alias '$2'"
        exit 1
    fi

    CURRENT_DATE=$(date +"%Y_%m_%d")
    local util='backup:get'
    local url=${url_aliases[$2]}
    local env=${3:-live}
    local flag_path="--to=$(eval echo ${4:-./$CURRENT_DATE.tar.gz})"
    local flag_element="--element=${5:-db}"
    echo "Command to run: terminus $util $url.$env $flag_element $flag_path"
    terminus "$util" "$url.$env" "$flag_element" "$flag_path"

}

terminus_export "$1" "$2" "$3" "$4" "$5"
