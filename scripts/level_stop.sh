#!/bin/bash
# basic script to stop a whole level
# $1 = level
# $2 = number of devices
# future: $3 = optional ISO fingerprint

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ); exec &>> "$LOGFILE"
echo "[$0] $(date) - CALL: level: $1 - devices: $2 - ISO: $3"

# to do: check for more complex calls (number of parameters)
if [ "$#" -eq 2 ]
then
    cd ../scripts/  # to make sure one is in /scripts/ folder
    echo "[$0] $(date) - STEP: delete network IPs";   sudo ./container_ip_del.sh "$1" "$2";   wait $!
    echo "[$0] $(date) - STEP: stop containers";      sudo ./container_stop.sh "$1" "$2";     wait $!
    echo "[$0] $(date) - STEP: delete containers";    sudo ./container_delete.sh "$1" "$2";   wait $!
    echo "[$0] $(date) - STEP: delete bridge";        sudo ./bridge_del.sh "$1";              wait $!
    echo -n "[$0] $(date) - STEP: return to path: "; cd -
    echo "[$0] $(date) - DONE: stopped level $1 with $2 devices"
else
    echo "[$0] $(date) - FAILED: invalid number of parameters"
fi