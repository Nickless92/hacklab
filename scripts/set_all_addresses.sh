#!/bin/bash


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