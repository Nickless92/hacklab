#!/bin/bash
# $1 = level

if [ $# = 1 ]
    sudo brctl addbr $1 up              # adds and starts a bridge named $1 
    sudo ip link set dev $1 up          # adds and starts the L2 link
    echo "created bridge for level $1"
else
    echo "[bridge_add] invalid number of parameters"
fi
