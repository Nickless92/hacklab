#!/bin/bash
# script to delete a lxd network bridge
# $1 = level

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/)
echo -n "*** " >> "$LOGFILE"; date=$(date); echo -n "$date" >> "$LOGFILE"; echo " ***" >> "$LOGFILE"

if [ $# = 1 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    sudo ip link set dev lvlbr$level down &>> "$LOGFILE"        # stops and deletes the L2 link $1
    sudo brctl delbr lvlbr$level &>> "$LOGFILE"                 # stops and deletes bridge named $1
    echo "[bridge_del] deleted bridge for level $level" &>> "$LOGFILE"
else
    echo "[bridge_del] invalid number of parameters" &>> "$LOGFILE"
fi
