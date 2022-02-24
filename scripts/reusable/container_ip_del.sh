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
        sudo lxc exec lvl"$level_"-d"$device_" -- ip link set dev "$interface" down &>> "$LOGFILE"
        sudo lxc exec lvl"$level_"-d"$device_" -- ip addr del 10.10."$1"."$device"/24 dev "$interface" &>> "$LOGFILE"
        lxc config device remove lvl"$level_"-d"$device_" "$interface" &>> "$LOGFILE"
    done
    echo "[container_start] try target container" &>> "$LOGFILE"
    sudo lxc exec lvl"$level_"-target -- ip link set dev "$interface" down &>> "$LOGFILE"
    sudo lxc exec lvl"$level_"-target -- ip addr del 10.10."$1".0/24 dev "$interface" &>> "$LOGFILE"
    lxc config device remove lvl"$level_"-target "$interface" &>> "$LOGFILE"
    echo "[container_ip_del] removed network from containers for level $1" &>> "$LOGFILE"
    exit 0
else
    echo "[container_ip_del] invalid number of parameters" &>> "$LOGFILE"
    exit 1
fi
