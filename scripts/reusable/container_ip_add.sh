#!/bin/bash
# script to connect devices to the lxc network bridge
# $1 = level
# $2 = number of devices
# $3 = interface [default = eno1]

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/)
echo -n "*** " >> "$LOGFILE"; date=$(date); echo -n "$date" >> "$LOGFILE"; echo " ***" >> "$LOGFILE"

if [ "$#" -eq 3 ] || [ "$#" -eq 2 ]
then
    if [ "$#" -eq 2 ]; then interface=eno1; else interface="$3"; fi
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi                             # check for leading '0'
    for ((device = 1; device <= "$2"; device++))
    do
        if [ "$device" -lt 10 ]; then device_=0"$device"; else device_="$device"; fi        # check for leading '0'
        sudo lxc config device add lvl"$level_"-d"$device_" "$interface" nic nictype=bridged parent=lvlbr"$level_" name="$interface" &>> "$LOGFILE"
        sudo lxc exec lvl"$level_"-d"$device_" -- ip addr add 10.10."$1"."$device"/24 dev "$interface" &>> "$LOGFILE"
        sudo lxc exec lvl"$level_"-d"$device_" -- ip link set dev "$interface" up &>> "$LOGFILE"
    done
    echo "[container_ip_add] try target container" &>> "$LOGFILE"
    sudo lxc config device add lvl"$level_"-target "$interface" nic nictype=bridged parent=lvlbr"$level_" name="$interface" &>> "$LOGFILE"
    sudo lxc exec lvl"$level_"-target -- ip addr add 10.10."$1".0/24 dev "$interface" &>> "$LOGFILE"
    sudo lxc exec lvl"$level_"-target -- ip link set dev "$interface" up &>> "$LOGFILE"
    echo "[container_ip_add] added network to containers for level $1" &>> "$LOGFILE"
else
    echo "[container_ip_add] invalid number of parameters" &>> "$LOGFILE"
fi
