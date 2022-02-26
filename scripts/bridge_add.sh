#!/bin/bash
# script to create a lxd network bridge
# $1 = level

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/); exec >> "$LOGFILE" 2>&1
echo -n "*** "; date=$(date); echo -n "$date"; echo " ***"

if [ $# = 1 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    sudo brctl addbr lvlbr$level up              # adds and starts a bridge named $1 
    sudo ip link set dev lvlbr$level up          # adds and starts the L2 link
    echo "[$0] DONE: created bridge for level $level"
else
    echo "[$0] FAIL: invalid number of parameters"
fi
