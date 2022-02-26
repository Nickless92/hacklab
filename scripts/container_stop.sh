#!/bin/bash
# script to stop containers of a level
# $1 = level
# $2 = number of devices

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/); exec >> "$LOGFILE" 2>&1
echo -n "*** "; date=$(date); echo -n "$date"; echo " ***"

if [ $# = 2 ]
then
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi
    for((device = 1; device <= "$2"; device++))                         # cycle through all devices of a level
    do
        if [ "$device" -lt 10 ]; then device_=0"$device"; else device_="$device"; fi
        sudo lxc stop lvl"$level_"-d"$device_"            # only STOPS the given lxc container
    done
    echo "[$0] try target container" 
    sudo lxc stop lvl"$level_"-target                     # in case there is a TARGET device
    echo "[$0] DONE: stopped containers for level $1" 
else
    echo "[$0] FAIL: invalid number of parameters" ;
fi
