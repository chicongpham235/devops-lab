#!/bin/bash

LOG_PATH="./nginx-access.log"

getTopIpAddress() {
    awk '{print $1}' "$LOG_PATH" | sort | uniq -c | sort -k1 -nr | /usr/bin/head -n 5 | awk '{print ""$2": "$1" requests"}'
}

getTopRequestsPath() {
    awk '{print $7}' "$LOG_PATH" | sort | uniq -c | sort -k1 -nr | /usr/bin/head -n 5 | awk '{print ""$2": "$1" requests"}'
}

getTopResponseStatusCodes() {
    grep -oE ' [1-5][0-9]{2} ' "$LOG_PATH" | sort | uniq -c | sort -k1 -nr | /usr/bin/head -n 5 | awk '{print ""$2": "$1" requests"}'
}

getTopUserAgents() {
    awk -F '"' '{print $6}' "$LOG_PATH" | sort | uniq -c | sort -k1 -nr | /usr/bin/head -n 5 | awk '{for (i=2;i<=NF;i++) printf ""$i ""; print ": "$1" requests"}'
}

main() {
    echo "Top 5 IP addresses with the most requests:"
    getTopIpAddress $LOG_PATH
    printf "\n"

    echo "Top 5 most requested paths:"
    getTopRequestsPath $LOG_PATH
    printf "\n"

    echo "Top 5 response status codes:"
    getTopResponseStatusCodes $LOG_PATH
    printf "\n"

    echo "Top 5 user agents"
    getTopUserAgents $LOG_PATH
    printf "\n"
}

main
