#!/bin/bash
# $1 = level
# $2 = number of devices

if [ $# = 2 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    for((device = 1; device <= $2; device++))
    do
        if [ "$device" -lt 10 ]; then device=0"$device"; fi
        lxc delete lvl"$level"-d"$device"   # deletes a stopped container
    done
    lxc delete lvl"$level"-target           # in case there is a target VM
    echo "deleted containers for level $1"
else
    echo "[container_del] invalid number of parameters"
fi
