#!/bin/bash

#sudo apt-get install brctl         # first, make sure brctl is installed

sudo brctl addbr $1 up              # adds and starts a bridge named $1 
sudo ip link set dev $1 up          # adds and starts the L2 link
echo "created bridge for level $1"

