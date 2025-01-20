#!/bin/bash

SCRIPT_PATH="./log-archive.sh"
LOG_FOLDER_PATH="./logs"

create_cronjob() {
    cron_line="0 * * * * ${SCRIPT_PATH} ${LOG_FOLDER_PATH}"
    (
        crontab -l 2>/dev/null
        echo "$cron_line"
    ) | crontab -
    echo "Cron job added: $cron_line"
}

create_cronjob
