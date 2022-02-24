#!/bin/bash
# basic script to stop a whole level
# $1 = level
# $2 = number of devices
# $3 = interface [default = eno1]

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/)
echo -n "*** " >> "$LOGFILE"; date=$(date); echo -n "$date" >> "$LOGFILE"; echo " ***" >> "$LOGFILE"
echo "level = $1 - devices = $2" &>> "$LOGFILE" 

# to do: check for more complex calls (number of parameters)
if [ "$#" -eq 2 ]
then
    sudo ./container_ip_del.sh "$1" "$2" &>> "$LOGFILE"; pause &>> "$LOGFILE"
    sudo ./container_stop.sh "$1" "$2" &>> "$LOGFILE"; pause &>> "$LOGFILE"
    sudo ./container_delete.sh "$1" "$2" &>> "$LOGFILE"; pause &>> "$LOGFILE"
    sudo ./bridge_del.sh "$1" &>> "$LOGFILE"; pause &>> "$LOGFILE"
    echo "[level_start] destroyed level $1 with $2 devices" &>> "$LOGFILE"
else
    echo "[level_start] invalid number of parameters" &>> "$LOGFILE"
fi