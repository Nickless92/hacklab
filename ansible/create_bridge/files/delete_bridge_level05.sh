#!/bin/bash

BRIDGENAME="lvlbr05"

sudo ip link set dev $BRIDGENAME down
sudo brctl delbr $BRIDGENAME 
