#!/bin/bash

level = 1
device = 1

while [ "$?" = 0 ]             # while return code = 0
do
    if [ "$level" -lt 10 ]     # checks need for leading 0
    then
        while [ "$?" = 0 ]     # while return code = 0
        do
            if [ "$device" -lt 10 ]     # level 0-9, device 0-9
            then
                lxc stop lvl0"$level"-d0"$device"
                lxc delete lvl0"$level"-d0"$device"
            else                        # level 0-9. device 10++
                lxc stop lvl0"$level"-d"$device"
                lxc delete level0"$counter"-d"$device"
	    fi
            device=$(( $device + 1 ))    # or $(( device++ ))
        done
    else
        while [ "$?" = 0 ]    # while return code = 0
        do
            if [ "$device" -lt 10 ]     # level 10++, device 0-9
            then
                lxc stop lvl"$level"-d0"$device"
                lxc delete lvl"$level"-d0"$device"
            else                        # level 10++. device 10++
                lxc stop lvl"$level"-d"$device"
                lxc delete level"$counter"-d"$device"
            fi
            device=$(( $device + 1 ))    # or $(( device++ ))
        done
    fi
    echo "[container_remove_all] removed level $level"
    level=$(( $level + 1 ))    # or $(( level++ ))
done
