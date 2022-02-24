#!/bin/bash
# $1 = level

if [ $# = 1 ]
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    sudo brctl addbr $level up              # adds and starts a bridge named $1 
    sudo ip link set dev $level up          # adds and starts the L2 link
    echo "created bridge for level $level"
else
    echo "[bridge_add] invalid number of parameters"
fi
