#!/bin/bash
# basic script to start a whole level; call with "sudo -E ~/hacklab/scripts/level_start.sh level devices"
# $1 = level
# $2 = number of devices
# future: $3 = optional ISO fingerprint 

#LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/ | sed s\#'^./'\#'~/hacklab/logs/'\# ) #| sed s\#'./'\#''\#)
LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/ ) # | sed s\#'./'\#'^~/hacklab/logs/'\# ) #| sed s\#'./'\#''\#)
echo "LOGFILE = $LOGFILE"; sudo exec >> "$LOGFILE" 2>&1
echo -n "*** "; date=$(date); echo -n "$date"; echo " ***"
echo "script: $0 - level: $1 - devices: $2"

# to do: check for more complex calls (number of parameters)
if [ "$#" -eq 2 ]
then
    sudo -E ~/hacklab/scripts/bridge_add.sh "$1"; wait $!
    sudo -E ~/hacklab/scripts/container_create.sh "$1" "$2"; wait $!
    sudo -E ~/hacklab/scripts/container_start.sh "$1" "$2"; wait $!
    sudo -E ~/hacklab/scripts/container_ip_add.sh "$1" "$2"; wait $!
    echo "[$0] DONE: started level $1 with $2 devices"
else
    echo "[$0] FAILED: invalid number of parameters"
fi