#!/bin/bash
# basic script to stop a whole level
# $1 = level
# $2 = number of devices
# future: $3 = optional ISO fingerprint

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^./'\#'./logs/'\# ); exec &>> "$LOGFILE"
echo "[$0] *** $(date) ***"; echo "[$0] level = $1 - devices = $2"

# to do: check for more complex calls (number of parameters)
if [ "$#" -eq 2 ]
then
    sudo ~/hacklab/scripts/container_ip_del.sh "$1" "$2"; wait $!
    sudo ~/hacklab/scripts/container_stop.sh "$1" "$2"; wait $!
    sudo ~/hacklab/scripts/container_delete.sh "$1" "$2"; wait $!
    sudo ~/hacklab/scripts/bridge_del.sh "$1"; wait $!
    echo "[$0] DONE: stopped level $1 with $2 devices"
else
    echo "[$0] $(date) - FAILED: invalid number of parameters"
fi