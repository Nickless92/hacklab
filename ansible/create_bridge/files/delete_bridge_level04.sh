#!/bin/bash

BRIDGENAME="lvlbr04"

sudo ip link set dev $BRIDGENAME down
sudo brctl delbr $BRIDGENAME 
