#!/bin/bash

# Function to display usage instructions
usage() {
    echo "Usage: $0 <log-directory>"
    exit 1
}

main() {
    # Check if the user has provided a log directory
    if [ "$#" -ne 1 ]; then
        usage
    fi

    #Variables
    LOG_OUTPUT_DIR=$
    LOG_SYS_DIR="/var/log"
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    LOG_OUTPUT_FILENAME="logs_archive_${TIMESTAMP}.tar.gz"

    # Create if not exists
    if [ ! -d "$LOG_OUTPUT_DIR" ]; then
        mkdir -p "$LOG_OUTPUT_DIR"
    fi

    #Compress
    tar -czvf "${LOG_OUTPUT_DIR}/${LOG_OUTPUT_FILENAME}" "$LOG_SYS_DIR"
}

main $# "$1"
