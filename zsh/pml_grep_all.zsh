#!/bin/zsh
TCRED_STORAGE_DIR="$HOME/tcred/storage"
source $TCRED_STORAGE_DIR/key_value_storage

handle_pml_grep_all() {

  local needle=$1
  local env=${2:-live}

  # for (i=1; i<${#url_aliases[@]}; i++)

  for key in ${(k)url_aliases[@]}; do
  site="${url_aliases[$key]}"
  # echo "terminus drush $site.$env -- pml | grep $needle"
  echo $site; terminus drush $site.$env -- pml | grep $needle
  done


 }