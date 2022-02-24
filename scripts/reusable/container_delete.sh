#!/bin/bash
# script to delete containers for a level (if stopped)
# $1 = level
# $2 = number of devices

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/)
echo -n "*** " >> "$LOGFILE"; date=$(date); echo -n "$date" >> "$LOGFILE"; echo " ***" >> "$LOGFILE"

if [ $# = 2 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    for((device = 1; device <= $2; device++))
    do
        if [ "$device" -lt 10 ]; then device_=0"$device"; else device_="$device"; fi
        sudo lxc delete lvl"$level"-d"$device_" &>> "$LOGFILE"  # deletes a stopped container
    done
    echo "[container_start] try target container" &>> "$LOGFILE"
    sudo lxc delete lvl"$level"-target &>> "$LOGFILE"           # in case there is a target VM
    echo "[container_delete] deleted containers for level $1" &>> "$LOGFILE"
else
    echo "[container_delete] invalid number of parameters" &>> "$LOGFILE"
fi
