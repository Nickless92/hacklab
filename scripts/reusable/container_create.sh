#!/bin/bash
# script to set up containers for a level (stopped, not running)
# $1 = level
# $2 = number of devices
# $3 = fingerprint of ISO [default = 5dd7ed85ba21]

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/)
echo -n "*** " >> "$LOGFILE"; date=$(date); echo -n "$date" >> "$LOGFILE"; echo " ***" >> "$LOGFILE"

if [ "$#" -eq 3 ] || [ "$#" -eq 2 ]
then
    if [ "$#" -eq 2 ]; then image=5dd7ed85ba21; else image="$3"; fi
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi                             # check for leading '0'
    for (( device=1; device <= "$2"; device++ ))
    do
        if [ "$device" -lt 10 ]; then device_=0"$device"; else device_="$device"; fi        # check for leading '0'
        lxc init "$image" lvl"$level_"-d"$device_" &>> "$LOGFILE"
    done
    echo "[container_create] created containers for level $level" &>> "$LOGFILE"
else
    echo "[container_create] invalid number of parameters" &>> "$LOGFILE"
fi
