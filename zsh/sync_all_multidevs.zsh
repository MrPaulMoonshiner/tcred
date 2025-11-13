#!/bin/zsh

TCRED_DIR="$HOME/tcred/zsh"
TCRED_STORAGE_DIR="$HOME/tcred/storage"
source $TCRED_STORAGE_DIR/key_value_storage

sync_all_multidevs() {

  local env=${2:-ims}

    if [[ "$3" == "--print" || "$3" == "-p" ]]; then
      for key in ${(k)url_aliases[@]}; do
        site="${url_aliases[$key]}"
         echo $site.$env; echo "Command to run: terminus multidev:merge-from-dev $site.$env"
      done
      exit 0
    fi

    for key in ${(k)url_aliases[@]}; do
      site="${url_aliases[$key]}"
      echo $site.$env; terminus multidev:merge-from-dev $site.$env; 
    done
}