#!/bin/bash
# script to delete a lxd network bridge
# $1 = level

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/); exec >> "$LOGFILE" 2>&1
echo -n "*** "; date=$(date); echo -n "$date"; echo " ***"

if [ $# = 1 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    sudo ip link set dev lvlbr$level down        # stops and deletes the L2 link $1
    sudo brctl delbr lvlbr$level                 # stops and deletes bridge named $1
    echo "[$0] DONE: deleted bridge for level $1"
else
    echo "[$0] FAIL: invalid number of parameters"
fi
