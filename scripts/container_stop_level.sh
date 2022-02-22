#!/bin/bash

# $1 = level
# $2 = number of devices

<<<<<<< Updated upstream
for((device = 1; device <= deviceend; device++))    # cycle through all devices of a level
=======
<<<<<<< Updated upstream
for((device = 1; device <= deviceend; device++))
>>>>>>> Stashed changes
do
    lxc stop lvl"$1"-d"$device"      # only STOPS the given lxc container
done
=======
if [ $# = 2 ]
then
    for((device = 1; device <= $2; device++))    # cycle through all devices of a level
    do
        lxc stop lvl"$1"-d"$device"      # only STOPS the given lxc container
    done
    lxc stop lvl"$1"-target              # in case there is a TARGET device
else
    echo "[container_stop_level] invalid number of parameters"
fi
>>>>>>> Stashed changes
