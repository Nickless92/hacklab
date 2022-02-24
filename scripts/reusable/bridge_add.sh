#!/bin/bash
# script to create a lxd network bridge
# $1 = level

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/)
echo -n "*** " >> "$LOGFILE"; date=$(date); echo -n "$date" >> "$LOGFILE"; echo " ***" >> "$LOGFILE"

if [ $# = 1 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    sudo brctl addbr lvlbr$level up &>> "$LOGFILE"              # adds and starts a bridge named $1 
    sudo ip link set dev lvlbr$level up &>> "$LOGFILE"          # adds and starts the L2 link
    echo "[bridge_add] created bridge for level $level" &>> "$LOGFILE"
else
    echo "[bridge_add] invalid number of parameters" &>> "$LOGFILE"
fi
