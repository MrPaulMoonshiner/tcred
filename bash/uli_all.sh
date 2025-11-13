#!/bin/bash
TCRED_STORAGE_DIR="$HOME/tcred/storage"
source $TCRED_STORAGE_DIR/key_value_storage
source $TCRED_STORAGE_DIR/data_storage

uli_all() {

  
  local env=${2:-live}


  for key in "${!url_aliases[@]}"; do
    site="${url_aliases[$key]}"
    read -p "Do you want to login to | Market: ${url_alias_host[$key]} | Site ID: $site | Environment: $env | ? [Y/n] " -r reply
    echo
    case "$reply" in
      ""|[Yy]*)
        if [ "$3" = "--report" ] || [ "$3" = "-r" ]; then
          echo "Market: $url_alias_host[$key]"
          echo "Site ID: $site"
          echo "Environment: $env"
        fi
        terminus drush "${site}.${env}" uli
        ;;
      *)
        echo "Skipped for site: $site env: $env."
        ;;
    esac
  done

}