#!/bin/bash

BRIDGENAME="lvlbr03"

sudo ip link set dev $BRIDGENAME down
sudo brctl delbr $BRIDGENAME 
