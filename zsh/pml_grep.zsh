#!/bin/zsh
TCRED_STORAGE_DIR="$HOME/tcred/storage"
source $TCRED_STORAGE_DIR/key_value_storage

handle_pml_grep() {
  if [[ -z ${url_aliases[$2]} ]]; then
      echo "Error: Unknown URL alias '$2'"
      exit 1
  fi

  local needle=$1
  local url=${url_aliases[$2]}
  local env=${3:-live}
  
  terminus drush "$url.$env" -- pml | grep $needle
 }