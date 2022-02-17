#!/bin/bash

BRIDGENAME="lvlbr01"

sudo ip link set dev $BRIDGENAME down
sudo brctl delbr $BRIDGENAME 