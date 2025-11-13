#!/bin/zsh

TCRED_DIR="$HOME/tcred/zsh"
TCRED_STORAGE_DIR="$HOME/tcred/storage"

# Function to run the command with the given variables
run_command() {

    if [[ "$1" == "--report" || "$1" == "-r" ]]; then
         source $HOME/tcred/counter/report.zsh
    fi

    source $HOME/tcred/counter/counter.zsh

    if [[ "$1" == "--uli_all" || "$1" == "-ua" ]]; then
         source $TCRED_DIR/uli_all.zsh
         uli_all $@
         exit 0
    fi

    if [[ "$1" == "--sync_multidev" || "$1" == "-sm" ]]; then
      source $TCRED_DIR/sync_multidev.zsh
      sync_multidev $@
      exit 0
    fi

    if [[ "$1" == "--sync_all_multidevs" || "$1" == "-sam" ]]; then
      if [[ "$2" == "live" ]]; then
          echo "Nice try! But you can't ruin live environments. Not in my watch!"
          exit 0
      fi
      if [[ "$2" == "dev" ]]; then
          echo "DEV environments under Sapient team control!"
          exit 0
      fi
      echo -n "Do you want to sync all $2 environments? (y/N) "
      if read -q; then
          echo
          source $TCRED_DIR/sync_all_multidevs.zsh
          sync_all_multidevs $@
          exit 0
      else
          echo
          echo "Sync cancelled."
          exit 1
      fi
      fi

    if [[ "$1" == "--pm:list" || "$1" == "-pml" ]]; then
         source $HOME/tcred/zsh/pml.zsh
         handle_pml $@
         exit 0
    fi

     if [[ "$1" == "--export_db"  ||  "$1" == "-dbex" ]]; then
        source $TCRED_DIR/export.zsh 
        exit 0
    fi

    # Check if --help is provided
    if [[ "$1" == "--help"  ||  "$1" == "-h"  ||  "$1" = "" ]]; then
        source $TCRED_DIR/creds_help.zsh 
        exit 0
    fi

    if [[ "$1" == "-i" ||  "$1" == "--import" ]]; then
        source $TCRED_DIR/import_handler.zsh
        local csv_file=$2
        import_from_csv $csv_file
        echo "import finished";
        exit 0
    fi

    local alias=$1
    local env=${2:-live}
    local action=${3:-uli}
    local util=${4:-drush}
    
    source $TCRED_STORAGE_DIR/key_value_storage
    # Resolve the URL alias
    local url=${url_aliases[$alias]}
    
    if [[ -z ${url_aliases[$alias]} ]]; then
        echo "Error: Unknown URL alias '$alias'"
        exit 1
    fi

    if [[ "$2" == "--print"  ||  "$2" == "-p" ]]; then
        local full_command="terminus $util $url.live $action"
        echo "Command to run: $full_command"
        exit 1;
    fi
   
   	 echo "terminus $util $url.$env $action"
   	 terminus "$util" "$url.$env" "$action"
}

# Call the function with the provided arguments
run_command "$@"