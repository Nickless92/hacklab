#!/bin/bash
# script to stop containers of a level
# $1 = level
# $2 = number of devices

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^./'\#'./logs/'\# ); exec &>> "$LOGFILE"
echo "[$0] *** $(date) ***"; echo "[$0] CALL: level: $1 - devices: $2"

if [ $# = 2 ]
then
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi
    for((device = 1; device <= "$2"; device++))                         # cycle through all devices of a level
    do
        if [ "$device" -lt 10 ]; then device_=0"$device"; else device_="$device"; fi
        echo "[$0] $(date) - STEP: stop device $device_"
        sudo lxc stop lvl"$level_"-d"$device_"            # only STOPS the given lxc container
    done
    echo "[$0] $(date) - STEP: try target container"
    sudo lxc stop lvl"$level_"-target                     # in case there is a TARGET device
    echo "[$0] $(date) - DONE: stopped containers for level $1" 
else
    echo "[$0] $(date) - FAIL: invalid number of parameters" ;
fi
