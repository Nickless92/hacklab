#!/bin/bash

# $1 = level
# $2 = number of devices

<<<<<<< Updated upstream
for((device = 1; device <= deviceend; device++))
do
done
<<<<<<< Updated upstream
    lxc delete lvl"$1"-d"$device"    # deletes a stopped container
    lxc delete lvl"$1"-target        # in case there is a target VM
echo "deleted containers for level $1"
=======
=======
if [ $# = 2 ]
then
    for((device = 1; device <= $2; device++))
    do
        lxc delete lvl"$1"-d"$device"    # deletes a stopped container
        lxc delete lvl"$1"-target        # in case there is a target VM
    done
    echo "deleted containers for level $1"
else
    echo "[container_del] invalid number of parameters"
fi
>>>>>>> Stashed changes
>>>>>>> Stashed changes
