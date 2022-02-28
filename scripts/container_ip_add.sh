#!/bin/bash
# script to connect devices to the lxc network bridge
# $1 = level
# $2 = number of devices
# $3 = interface [default = eno1]

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ); exec &>> "$LOGFILE"
echo "[$0] $(date) - CALL: level: $1 - devices: $2 - interface: $3"

if [ "$#" -eq 3 ] || [ "$#" -eq 2 ]
then
    if [ "$#" -eq 2 ]; then interface=eno1; else interface="$3"; fi
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi                             # check for leading '0'
    for ((device = 1; device <= "$2"; device++))
    do
        if [ "$device" -lt 10 ]; then device_=0"$device"; else device_="$device"; fi        # check for leading '0'
        echo "[$0] $(date) - STEP: add IP to device $device_"
        sudo lxc config device add lvl"$level_"-d"$device_" "$interface" nic nictype=bridged parent=lvlbr"$level_" name="$interface" 
        sudo lxc exec lvl"$level_"-d"$device_" -- ip addr add 10.10."$1"."$device"/24 dev "$interface" 
        sudo lxc exec lvl"$level_"-d"$device_" -- ip link set dev "$interface" up 
    done
    echo "[$0] $(date) - STEP: try target container" 
    sudo lxc config device add lvl"$level_"-target "$interface" nic nictype=bridged parent=lvlbr"$level_" name="$interface" 
    sudo lxc exec lvl"$level_"-target -- ip addr add 10.10."$1".0/24 dev "$interface" 
    sudo lxc exec lvl"$level_"-target -- ip link set dev "$interface" up 
    echo "[$0] $(date) - DONE: added network to containers for level $1" 
else
    echo "[$0] $(date) - FAIL: invalid number of parameters" 
fi
