#!/bin/bash

# see ~/hacklab/scripts/start_level01.sh for details

ETH1=eno1
level=3
deviceend=3

if [ $level -lt 10 ]
then
sudo brctl addbr lvlbr0"$level" up
sudo ip link set dev lvlbr0"$level" up
else
sudo brctl addbr lvlbr"$level" up
sudo ip link set dev lvlbr"$level" up
fi

ansible-playbook /home/test/hacklab/ansible/create_container_level03.yaml

for ((device = 1; device <= deviceend; device++))
do
    lxc start lvl"$level"-d"$device"
    sudo lxc config device add lvl"$level"-d"$device" "$ETH1" nic nictype=bridged parent=lvlbr0"$level" name="$ETH1"
    sudo lxc exec lvl"$level"-d"$device" -- ip addr add 10.10."$level"."$device"/24 dev "$ETH1"  
    sudo lxc exec lvl"$level"-d"$device" -- ip link set dev "$ETH1" up
done