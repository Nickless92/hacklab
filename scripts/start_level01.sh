#!/bin/bash

# script to fully set up a hole network (level 01)
# consisting of 3 devices + 1 bridge

ETH1=eno1                                                                                  #name of the device the container gets                          
level=1                           
deviceend=3

# check for leading '0'
if [ $level -lt 10 ]
then
    # adds and starts a bridge named lvlbr01, lvlbr02, ...
    sudo brctl addbr lvlbr0"$level" up
    # adds and starts the L2 link
    sudo ip link set dev lvlbr0"$level" up
else
    # in case of level >= 10
    sudo brctl addbr lvlbr"$level" up
    sudo ip link set dev lvlbr"$level" up
fi

# run ansible playbook to create containers for level 01
# see there for details
ansible-playbook /home/test/hacklab/ansible/create_container_level01.yaml                   #executes the ansible-playbook which generates the container for the current level

# add all (given) devices to the network
for ((device = 1; device <= deviceend; device++))
do
    # containers are stopped by playbook -> start them first
    lxc start lvl"$level"-d"$device"
    # add a connection from bridge to containers 'lvl01-d1', 'lvl01-d2', ...
    sudo lxc config device add lvl"$level"-d"$device" "$ETH1" nic nictype=bridged parent=lvlbr0"$level" name="$ETH1"
    # add IP 10.10.level.device/24
    sudo lxc exec lvl"$level"-d"$device" -- ip addr add 10.10."$level"."$device"/24 dev "$ETH1"  
    # start L2 link
    sudo lxc exec lvl"$level"-d"$device" -- ip link set dev "$ETH1" up
done