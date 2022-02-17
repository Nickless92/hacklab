#!/bin/bash

BRIDGENAME="lvlbr04"

sudo brctl addbr $BRIDGENAME up
sudo ip link set dev $BRIDGENAME up
