#!/bin/bash

<<<<<<< Updated upstream
#sudo apt-get install brctl         # first, make sure brctl is installed

sudo brctl addbr $1 up              # adds and starts a bridge named $1 
sudo ip link set dev $1 up          # adds and starts the L2 link
echo "created bridge for level $1"

=======
<<<<<<< Updated upstream
sudo brctl addbr $1 up
sudo ip link set dev $1 up
echo "created $1"
=======
# $1 = level

#sudo apt-get install brctl         # first, make sure brctl is installed
if [ $# = 1 ]
    sudo brctl addbr $1 up              # adds and starts a bridge named $1 
    sudo ip link set dev $1 up          # adds and starts the L2 link
    echo "created bridge for level $1"
else
    echo "[bridge_add] invalid number of parameters"
fi
>>>>>>> Stashed changes
>>>>>>> Stashed changes
