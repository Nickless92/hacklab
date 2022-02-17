#!/bin/bash

BRIDGENAME="lvlbr02"

sudo brctl addbr $BRIDGENAME up
sudo ip link set dev $BRIDGENAME up
