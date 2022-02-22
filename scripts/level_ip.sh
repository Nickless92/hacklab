#!/bin/bash

# $1 = level OR 'all'
# $2 = number of devices
# $3 = interface [eno1]

# # # EXPERIMENTAL (below) # # #
# set IP addresses for all containers in all levels
echo "[ip_set_all] note: this is experimental!"

if [ "$1" = "all" ] && [ "$#" = 1 ]
then
    interface=eno1    # standard interface bridge<-->container
    level=1           # cycle through all levels, begin with 1

    echo ""
    while [ $? = 0 ]
    do
        if [ "$level" -lt 10 ] then level=0"$level" fi
        echo "$level"
        device=1
        echo ""
        while [ $? = 0 ]    # cycle through all devices (inside level 10++)
        do
            # add a leading 0 if necessary
            if [ "$device" -lt 10 ] then device=0"$device" fi

            # add device to bridge
            sudo lxc config device add lvl"$level"-d"$device" "$interface" nic nictype=bridged parent=lvlbr"$level" name="$interface"
            # add IP 10.10.level.device/24
            sudo lxc exec lvl"$level"-d"$device" -- ip addr add 10.10."$level"."$device"/24 device "$interface"
            # start L2 link
            sudo lxc exec lvl"$level"-d"$device" -- ip link set dev "$interface" up
            #((device++))
        done
        echo "[ip_set_all] set addresses for level $level"
        #((level++))
    done
    echo "[ip_set_all] --- done ---"

elif [ "$1" = all ]
then
    echo "[level_ip] invalid number of parameters (only 'all' is accepted here)"
 # # # EXPERIMENTAL (above) # # #

else
    # this adds standard interface parameter (if not provided)
    if [ "$1" -ne "all" ] && [ "$#" = 2 ] then interface="eno1" fi

    # this adds a leading 0 where necessary
    if [ "$level" -lt 10 ] then level=0"$level" fi

    for ((device = 1; device -le "$2"; device++))
    do
        # this adds a leading 0 where necessary
        if [ "$device" -lt 10 ] then device=0"$device" fi
        # add device to bridge
        sudo lxc config device add lvl"$level"-d"$device" "$interface" nic nictype=bridged parent=lvlbr"$level" name="$interface"
        # add IP 10.10.level.device/24
        sudo lxc exec lvl"$level"-d"$device" -- ip addr add 10.10."$level"."$device"/24 dev "$interface"
        # start L2 link
        sudo lxc exec lvl"$level"-d"$device" -- ip link set dev "$interface" up
    done
fi
