#!/bin/bash

# $1 = level

if [ $# = 1 ]
    sudo ip link set dev $1 down        # stops L2 link $1
    sudo brctl delbr $1                 # stops and deletes bridge named $1
    echo "deleted bridge for level $1"
else
    echo "[bridge_del] invalid number of parameters"
fi

