#!/bin/bash
# basic script to start a whole level; call with "sudo -E ~/hacklab/scripts/level_start.sh level devices"
# $1 = level
# $2 = number of devices
# future: $3 = optional ISO fingerprint

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'./logs/'\# ); exec &>> "$LOGFILE"
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ); exec &>> "$LOGFILE"
echo "[$0] $(date) - CALL: level: $1 - devices: $2 - ISO: $3"

# to do: check for more complex calls (number of parameters)
if [ "$#" -eq 2 ]
then
    cd ../scripts/  # to make sure one is in /scripts/ folder
    echo "[$0] $(date) - STEP: add bridge";       sudo -E ./bridge_add.sh "$1";           wait $!
    echo "[$0] $(date) - STEP: init containers";  sudo -E ./container_create.sh "$1" "$2";wait $!
    echo "[$0] $(date) - STEP: start containers"; sudo -E ./container_start.sh "$1" "$2"; wait $!
    echo "[$0] $(date) - STEP: add network IPs";  sudo -E ./container_ip_add.sh "$1" "$2";wait $!
    echo -n "[$0] $(date) - STEP: return to path: "; cd -
    echo "[$0] $(date) - DONE: started level $1 with $2 devices"
else
    echo "[$0] $(date) - FAILED: invalid number of parameters"
fi