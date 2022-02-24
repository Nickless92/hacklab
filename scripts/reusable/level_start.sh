#!/bin/bash
# basic script to start a whole level
# $1 = level
# $2 = number of devices
# $3 = interface [default = eno1]

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/)
echo -n "*** " >> "$LOGFILE"; date=$(date); echo -n "$date" >> "$LOGFILE"; echo " ***" >> "$LOGFILE"
echo "level = $1 - devices = $2" &>> "$LOGFILE" 

if [ "$#" -eq 2 ]
then
    sudo ./bridge_add.sh "$1"; pause &>> "$LOGFILE"
    sudo ./container_create.sh "$1" "$2"; pause &>> "$LOGFILE"
    sudo ./container_start.sh "$1" "$2"; pause &>> "$LOGFILE"
    sudo ./container_ip_add.sh "$1" "$2"; pause &>> "$LOGFILE"
    echo "[level_start] created level $1 with $2 devices" &>> "$LOGFILE"
else
    echo "[level_start] invalid number of parameters" &>> "$LOGFILE"
fi