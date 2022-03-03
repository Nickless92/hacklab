#!/bin/bash
# script to start containers of a level
# $1 = level
# $2 = number of containers

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'./logs/'\# ); exec &>> "$LOGFILE"
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ); exec &>> "$LOGFILE"
echo "[$0] $(date) - CALL: level: $1 - containers: $2"

if [ $# = 2 ]
then
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi
    for((container = 1; container <= "$2"; container++))     # cycle through all containers of a level
    do
        if [ "$container" -lt 10 ]; then container_=0"$container"; else container_="$container"; fi
        echo "[$0] $(date) - STEP: start container $container_"
        sudo lxc start lvl"$level_"-c"$container_"           # only STOPS the given lxc container
    done
    echo "[$0] $(date) - try target container" 
    sudo lxc start lvl"$level_"-target                    # in case there is a TARGET container
    echo "[$0] $(date) - DONE: started containers for level $1" 
else
    echo "[$0] $(date) - FAIL: invalid number of parameters" 
fi
