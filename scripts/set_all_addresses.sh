#!/bin/bash

# $1 = level
# $2 = number of devices
# $3 = interface [eno1]

<<<<<<< Updated upstream
#CONTAINER_LVL1_D1=lvl1-d1
#CONTAINER_LVL1_D2=lvl1-d2
#CONTAINER_LVL1_D3=lvl1-d3

#BRIDGELVL1=lvlbr01

#ETH1=eno1

#CIDR_IP_LVL1_D1=10.10.1.1/24


#sudo lxc config device add "$CONTAINER_LVL1_D1" "$ETH1" nic nictype=bridged parent="$BRIDGELVL1" name="$ETH1"
#sudo lxc exec "$CONTAINER_LVL1_D1" -- ip addr add "$CIDR_IP_LVL1_D1" dev "$ETH1"
#sudo lxc exec "$CONTAINER_LVL1_D1" -- ip link set dev "$ETH1" up

ETH1=eno1
levelend=5
deviceend=3

# cycle through all (given) levels
for ((level = 1; level <= levelend; level++))
do
    # cycle through all (given) devices (inside a level)
    for ((device = 1; device <= deviceend; device++))
    do
        # add device to bridge
        sudo lxc config device add lvl"$level"-d"$device" "$ETH1" nic nictype=bridged parent=lvlbr0"$level" name="$ETH1"
        # add IP 10.10.level.device/24
        sudo lxc exec lvl"$level"-d"$device" -- ip addr add 10.10."$level"."$device"/24 dev "$ETH1"  
        # start L2 link
        sudo lxc exec lvl"$level"-d"$device" -- ip link set dev "$ETH1" up
    done
done
=======
# cycle through all (given) devices (inside a level)
for ((device = 1; device -le deviceend; device++))
do
    # add device to bridge
    sudo lxc config device add lvl"$level"-d"$device" "$interface" nic nictype=bridged parent=lvlbr0"$level" name="$interface"
    # add IP 10.10.level.device/24
    sudo lxc exec lvl"$level"-d"$device" -- ip addr add 10.10."$level"."$device"/24 dev "$interface"
    # start L2 link
    sudo lxc exec lvl"$level"-d"$device" -- ip link set dev "$interface" up
done
# # # EXPERIMENTAL # # #
# set IP addresses for all containers in all levels
# # # EXPERIMENTAL # # #

echo "[ip_set_all] note: this is experimental!"

interface=eno1    # standard interface bridge<-->container
level=1           # cycle through all levels, begin with 1
while [ $? = 0 ]
do
    device=1
    if [ "$level" -lt 10 ]
    then
        while [ $? = 0 ]    # cycle through all devices (inside level 0...9)
        do
            # add device to bridge
            sudo lxc config device add lvl0"$level"-d"$device" "$interface" nic nictype=bridged parent=lvlbr0"$level" name="$interface"
            # add IP 10.10.level.device/24
            sudo lxc exec lvl0"$level"-d"$device" -- ip addr add 10.10."$level"."$device"/24 dev "$interface"
            # start L2 link
            sudo lxc exec lvl0"$level"-d"$device" -- ip link set dev "$interface" up
            device=$(( $device + 1))
        done
    else
        while [ $? = 0 ]    # cycle through all devices (inside level 10++)
        do
            # add device to bridge
            sudo lxc config device add lvl"$level"-d"$device" "$interface" nic nictype=bridged parent=lvlbr"$level" name="$interface"
            # add IP 10.10.level.device/24
            sudo lxc exec lvl"$level"-d"$device" -- ip addr add 10.10."$level"."$device"/24 device "$interface"
            # start L2 link
            sudo lxc exec lvl"$level"-d"$device" -- ip link set dev "$interface" up
            device=$(( $device + 1))
        done
    echo "[ip_set_all] set addresses for level $level"
    level=$(( $level + 1 ))
done
>>>>>>> Stashed changes
