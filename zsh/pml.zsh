#!/bin/zsh
TCRED_STORAGE_DIR="$HOME/tcred/storage"
source $TCRED_STORAGE_DIR/key_value_storage

handle_pml() {
  
     if [[ "$2" == "--grep" || "$2" == "-g" ]]; then
         source $HOME/tcred/zsh/pml_grep.zsh
         handle_pml_grep $3 $4 $5
         exit 0
    fi

    if [[ "$2" == "--grep-all" || "$2" == "-ga" ]]; then
         source $HOME/tcred/zsh/pml_grep_all.zsh
        handle_pml_grep_all $3 $4
         exit 0
    fi
    
     if [[ -z ${url_aliases[$2]} ]]; then
        echo "Error: Unknown URL alias '$2'"
        exit 1
    fi

    local env=${3:-live}
    local url=${url_aliases[$2]}

   terminus drush "$url.$env" -- pml
}