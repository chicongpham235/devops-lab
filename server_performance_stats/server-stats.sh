# shellcheck disable=SC2148
get_cpu_usage() {
    echo "CPU Usage:"
    if uname -a | grep -i "linux"; then
        mpstat | grep all | awk '{print "CPU(%): "100-$12"%"}'
    elif uname -a | grep -i "darwin"; then
        top -l 1 | grep -E "^CPU" | awk '{print "CPU(%): " 100 - $7 "%"}'
    fi
}

get_memory_usage() {
    echo "Meomry Usage:"
    if uname -a | grep -i "linux"; then
        free -h | grep -i "mem" | awk '{print "Used: "$3" / Total: "$2" ("$3*100/$2"%)"}'
    elif uname -a | grep -i "darwin"; then
        vm_stat | perl -ne '/page size of (\d+)/ and $size=$1;
            /Pages free: \s+(\d+)/ and $free=$1;
            /Pages active: \s+(\d+)/ and $active=$1;
            /Pages inactive: \s+(\d+)/ and $inactive=$1;
            /Pages speculative: \s+(\d+)/ and $speculative=$1;
            /Pages wired down: \s+(\d+)/ and $wired=$1;
            /Pages occupied by compressor: \s+(\d+)/ and $compressor=$1;
            END {
                $gb2bytes=1073741824;
                $total=($free+$active+$inactive+$speculative+$wired+$compressor)*$size/$gb2bytes;
                $free=($free+$speculative+$inactive)*$size/$gb2bytes;
                $used=$total-$free;
                printf("Used: %.2fG / Total: %.2fG (%.2f%)\n",$used,$total,$used*100/$total);
            }'
    fi
}

get_disk_usage() {
    echo "Disk Usage:"
    df -h / | grep '/' | awk '{print "Disk Used: "$2-$4 "Gi" " / Total: " $2 " ("($2-$4)*100/$2"%)"}'
}

get_top_cpu_processes() {
    echo "Top 5 process by CPU usage:"
    # ps -Ao user,uid,pid,pcpu,command -r | head -n 6
    ps -Ao user,uid,pid,pcpu,command | awk 'NR==1 {print; next} {print | "sort -k4 -nr"}' | /usr/bin/head -n 6
}

get_top_memory_processes() {
    echo "Top 5 process by memory usage:"
    ps -Ao user,uid,pid,pmem,command | awk 'NR==1 {print; next} {print | "sort -k4 -nr"}' | /usr/bin/head -n 6
}

main() {
    echo "Server Performance Stats"
    echo "------------------------"
    printf "\n"

    get_cpu_usage
    printf "\n"

    get_memory_usage
    printf "\n"

    get_disk_usage
    printf "\n"

    get_top_cpu_processes
    printf "\n"

    get_top_memory_processes
    printf "\n"
}

main
