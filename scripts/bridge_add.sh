#!/bin/bash
# script to create a lxd network bridge
# $1 = level

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ); exec &>> "$LOGFILE"
echo "[$0] $(date) - CALL: level: $1"

if [ $# = 1 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    echo "[$0] $(date) - STEP: create bridge $level"
    sudo brctl addbr lvlbr$level up              # adds and starts a bridge named $1 
    sudo ip link set dev lvlbr$level up          # adds and starts the L2 link
    echo "[$0] $(date) - DONE: created bridge for level $level"
else
    echo "[$0] $(date) - FAIL: invalid number of parameters"
fi
