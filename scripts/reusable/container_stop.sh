#!/bin/bash
# script to stop containers of a level
# $1 = level
# $2 = number of devices

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/)
echo -n "*** " >> "$LOGFILE"; date=$(date); echo -n "$date" >> "$LOGFILE"; echo " ***" >> "$LOGFILE"

if [ $# = 2 ]
then
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi
    for((device = 1; device <= "$2"; device++))                         # cycle through all devices of a level
    do
        if [ "$device" -lt 10 ]; then device_=0"$device"; else device_="$device"; fi
        sudo lxc stop lvl"$level_"-d"$device_" &>> "$LOGFILE"           # only STOPS the given lxc container
    done
    echo "[container_start] try target container" &>> "$LOGFILE"
    sudo lxc stop lvl"$level_"-target &>> "$LOGFILE"                    # in case there is a TARGET device
    echo "[container_stop] stopped containers for level $1" &>> "$LOGFILE"
else
    echo "[container_stop] invalid number of parameters" &>> "$LOGFILE";
fi
