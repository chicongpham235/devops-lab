#!/bin/bash

SCRIPT_PATH="./log-archive.sh"
LOG_FOLDER_PATH="./logs"

create_cronjob() {
    cron_line="0 * * * * ${SCRIPT_PATH} ${LOG_FOLDER_PATH}"
    crontab -l >mycron
    echo "$cron_line" >mycron
    crontab mycron
    rm mycron
}

create_cronjob
