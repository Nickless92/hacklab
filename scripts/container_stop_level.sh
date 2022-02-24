#!/bin/bash

# $1 = level
# $2 = number of devices

if [ $# = 2 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    for((device = 1; device <= $2; device++))   # cycle through all devices of a level
    do
        if [ "$device" -lt 10 ]; then device=0"$1"; fi
        lxc stop lvl"$level"-d"$device"         # only STOPS the given lxc container
    done
    lxc stop lvl"$level"-target                 # in case there is a TARGET device
else
    echo "[container_stop_level] invalid number of parameters"
fi
