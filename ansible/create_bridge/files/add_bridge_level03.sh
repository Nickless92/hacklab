#!/bin/bash

BRIDGENAME="lvlbr03"

sudo brctl addbr $BRIDGENAME up
sudo ip link set dev $BRIDGENAME up
