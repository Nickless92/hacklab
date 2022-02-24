#!/bin/bash

# $1 = level
# $2 = number of devices
# $3 = interface [eno1]

level_=$1
if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
for ((device = 1; device -le "$2""; device++))      # cycle through all (given) devices (inside a level)
do
    device_=device
    if [ "$device" -lt 10 ]; then device=0"$2"; fi
    sudo lxc config device add lvl"$level"-d"$device" "$interface" nic \    # add device to bridge
    nictype=bridged parent=lvlbr"$level" name="$interface"

    sudo lxc exec lvl"$level"-d"$device" -- \                               # add ip 10.10.level.device/24
    ip addr add 10.10."$level_"."$device_"/24 dev "$interface"
    
    sudo lxc exec lvl"$level"-d"$device" -- \                               # start L2 link
    ip link set dev "$interface" up
done
