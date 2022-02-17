#!/bin/bash

BRIDGENAME="lvlbr01"

sudo brctl addbr $BRIDGENAME up
sudo ip link set dev $BRIDGENAME up