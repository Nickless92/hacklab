#!/bin/bash
# script to delete containers for a level (if stopped)
# $1 = level
# $2 = number of devices

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/); exec >> "$LOGFILE" 2>&1
echo -n "*** "; date=$(date); echo -n "$date"; echo " ***"

if [ $# = 2 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    for((device = 1; device <= $2; device++))
    do
        if [ "$device" -lt 10 ]; then device_=0"$device"; else device_="$device"; fi
        sudo lxc delete lvl"$level"-d"$device_"   # deletes a stopped container
    done
    echo "[$0] try target container" 
    sudo lxc delete lvl"$level"-target            # in case there is a target VM
    echo "[$0] DONE: deleted containers for level $1" 
else
    echo "[$0] FAIL: invalid number of parameters" 
fi
