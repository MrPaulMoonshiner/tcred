#!/bin/zsh

TCRED_STORAGE_DIR="$HOME/tcred/storage"
source $TCRED_STORAGE_DIR/key_value_storage

terminus_export() {
    local url=${url_aliases[$1]}
    local env=$2
    local util='backup:get'
    local flag_db="--element=$3"
    local flag_path=$4

    echo "terminus $util $url.$env $flag_db --to=$flag_path"

}