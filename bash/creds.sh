#!/bin/bash

TCRED_DIR="$HOME/tcred/bash"
TCRED_STORAGE_DIR="$HOME/tcred/storage"

# Function to run the command with the given variables
run_command() {

    if [[ "$1" == "--report" || "$1" == "-r" ]]; then
         source $HOME/tcred/counter/report.sh
    fi

    source $HOME/tcred/counter/counter.sh

     if [[ "$1" == "--export_db"  ||  "$1" == "-dbex" ]]; then
        source $TCRED_DIR/export.sh 
        exit 0
    fi

    # Check if --help is provided
    if [[ "$1" == "--help"  ||  "$1" == "-h"  ||  "$1" = "" ]]; then
        source $TCRED_DIR/creds_help.sh 
        exit 0
    fi

    if [[ "$1" == "-i" ||  "$1" == "--import" ]]; then
        source $TCRED_DIR/import_handler.sh
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
run_command "$1" "$2" "$3" "$4"