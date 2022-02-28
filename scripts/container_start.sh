#!/bin/bash
# script to start containers of a level
# $1 = level
# $2 = number of devices

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^./scripts/'\#'scripts/logs/'\# ); exec &>> "$LOGFILE"
echo "[$0] *** $(date) ***"; echo "[$0] level = $1 - devices = $2"

if [ $# = 2 ]
then
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi
    for((device = 1; device <= "$2"; device++))     # cycle through all devices of a level
    do
        if [ "$device" -lt 10 ]; then device_=0"$device"; else device_="$device"; fi
        sudo lxc start lvl"$level_"-d"$device_"           # only STOPS the given lxc container
    done
    echo "[$0] try target container" 
    sudo lxc start lvl"$level_"-target                    # in case there is a TARGET device
    echo "[$0] DONE: started containers for level $1" 
else
    echo "[$0] FAIL: invalid number of parameters" 
fi
