#!/bin/bash

sudo brctl addbr $1 up
sudo ip link set dev $1 up
echo "created $1"
