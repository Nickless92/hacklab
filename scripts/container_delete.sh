#!/bin/bash
# script to delete containers for a level (if stopped)
# $1 = level
# $2 = number of devices

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^./'\#'./logs/'\# ); exec &>> "$LOGFILE"
echo "[$0] *** $(date) ***"; echo "[$0] CALL: level: $1 - devices: $2"

if [ $# = 2 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    for((device = 1; device <= $2; device++))
    do
        if [ "$device" -lt 10 ]; then device_=0"$device"; else device_="$device"; fi
        echo "[$0] $(date) - STEP: delete device $device_"
        sudo lxc delete lvl"$level"-d"$device_"   # deletes a stopped container
    done
    echo "[$0] $(date) - STEP: try target container" 
    sudo lxc delete lvl"$level"-target            # in case there is a target VM
    echo "[$0] $(date) - DONE: deleted containers for level $1" 
else
    echo "[$0] $(date) - FAIL: invalid number of parameters" 
fi
