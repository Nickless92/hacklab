#!/bin/bash
# basic script to stop a whole level
# $1 = level
# $2 = number of devices
# future: $3 = optional ISO fingerprint 

#LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/ | sed s\#'^./'\#'~/hacklab/logs/'\# ) #| sed s\#'./'\#''\#)
LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/ ) # | sed s\#'./'\#'^~/hacklab/logs/'\# ) #| sed s\#'./'\#''\#)
echo "LOGFILE = $LOGFILE"; sudo exec >> "$LOGFILE" 2>&1
echo -n "*** "; date=$(date); echo -n "$date"; echo " ***"
echo "level = $1 - devices = $2" 

# to do: check for more complex calls (number of parameters)
if [ "$#" -eq 2 ]
then
    sudo $path/../scripts/reusable/container_ip_del.sh "$1" "$2"; wait $!
    sudo $path/../scripts/reusable/container_stop.sh "$1" "$2"; wait $!
    sudo $path/../scripts/reusable/container_delete.sh "$1" "$2"; wait $!
    sudo $path/../scripts/reusable/bridge_del.sh "$1"; wait $!
    echo "[$0] DONE: stopped level $1 with $2 devices"
else
    echo "[$0] FAILED: invalid number of parameters"
fi