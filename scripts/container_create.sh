#!/bin/bash
# script to set up containers for a level (stopped, not running)
# $1 = level
# $2 = number of devices
# $3 = optional: fingerprint of ISO [default = 5dd7ed85ba21]

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'scripts/'\#'scripts/logs/'\# ); exec &>> "$LOGFILE"
echo "[$0] *** $(date) ***"; echo "[$0] level = $1 - devices = $2"

if [ "$#" -eq 3 ] || [ "$#" -eq 2 ]
then
    #if [ "$#" -eq 2 ]; then image=5dd7ed85ba21; else image="$3"; fi
    if [ "$#" -eq 2 ]; then image="alpine-iso-utils"; else image="$3"; fi
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi                             # check for leading '0'
    for (( device=1; device <= "$2"; device++ ))
    do
        if [ "$device" -lt 10 ]; then device_=0"$device"; else device_="$device"; fi        # check for leading '0'
        sudo lxc init "$image" lvl"$level_"-d"$device_" 
    done
    echo "[$0] DONE: created containers for level $level" 
else
    echo "[$0] FAIL: invalid number of parameters" 
fi
