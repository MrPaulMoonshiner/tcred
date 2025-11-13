#!/bin/zsh

TCRED_DIR="$HOME/tcred/zsh"
TCRED_STORAGE_DIR="$HOME/tcred/storage"
source $TCRED_STORAGE_DIR/key_value_storage

sync_multidev() {

    if [[ -z ${url_aliases[$2]} ]]; then
        echo "Error: Unknown URL alias '$2'"
        exit 1
    fi

    local url=${url_aliases[$2]}
    local env=${3:-ims}

    if [[ "$4" == "--print" || "$4" == "-p" ]]; then
        echo "Command to run: terminus multidev:merge-from-dev $url.$env"
        exit 0
    fi

    terminus multidev:merge-from-dev $url.$env
}