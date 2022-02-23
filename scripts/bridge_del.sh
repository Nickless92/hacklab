#!/bin/bash
# $1 = level

if [ $# = 1 ]
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    sudo ip link set dev $level down        # stops and deletes the L2 link $1
    sudo brctl delbr $level                 # stops and deletes bridge named $1
    echo "deleted bridge for level $level"
else
    echo "[bridge_del] invalid number of parameters"
fi
