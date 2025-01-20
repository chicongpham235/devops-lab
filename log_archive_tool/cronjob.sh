#!/bin/bash

BASEDIR="$(
    cd -- "$(dirname "$0")" >/dev/null 2>&1
    pwd -P
)"
SCRIPT_PATH="${BASEDIR}/log-archive.sh"
LOG_FOLDER_PATH=$1

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <log-directory>"
    LOG_FOLDER_PATH="${BASEDIR}/logs"
    echo "Default log directory is setted ${LOG_FOLDER_PATH}"
fi

create_cronjob() {
    cron_line="0 * * * * ${SCRIPT_PATH} ${LOG_FOLDER_PATH}"
    (
        crontab -l 2>/dev/null
        echo "$cron_line"
    ) | crontab -
    echo "Cron job added: $cron_line"
}

create_cronjob
