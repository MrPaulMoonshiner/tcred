#!/bin/zsh

TCRED_STORAGE_DIR="$HOME/tcred/storage"
source $TCRED_STORAGE_DIR/key_value_storage

terminus_export() {
    local util='backup:get'
    local url=${url_aliases[$1]}
    local env=$2
    local flag_path="--to=$(eval echo $3)"
    local flag_element="--element=$4"

    echo "terminus $util $url.$env $flag_element $flag_path"

}