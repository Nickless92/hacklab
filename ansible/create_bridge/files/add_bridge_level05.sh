#!/bin/bash

BRIDGENAME="lvlbr05"

sudo brctl addbr $BRIDGENAME up
sudo ip link set dev $BRIDGENAME up
