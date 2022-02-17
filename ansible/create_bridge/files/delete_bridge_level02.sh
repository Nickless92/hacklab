#!/bin/bash

BRIDGENAME="lvlbr02"

sudo ip link set dev $BRIDGENAME down
sudo brctl delbr $BRIDGENAME 
