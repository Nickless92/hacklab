#!/bin/bash

# SPDX-FileCopyrightText: 2022 Bassam-Khaled Thiab <inf3891@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Dominic Meyer <inf3644@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Felix Rheinheimer <felix.rheinheimer@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Jean-Arole Fotsing <inf3608@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Katrin Vollhardt <inf3493@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Steve Landry Tchamabe <infXXXX@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Syed Saad-Ullah <inf3664@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Thierry-Junior Djeutchou-Njieyong <inf3494@hs-worms.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# script to connect containers to the lxc network bridge
# $1 = level
# $2 = number of containers
# $3 = interface [default = eth0]

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'\.log'\# | sed s\#'^.*/'\#'./logs/'\# ); exec &>> "$LOGFILE"
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'\.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ); exec &>> "$LOGFILE"
echo "[$0] $(date) - CALL: level: $1 - containers: $2 - interface: $3"

if [ "$#" -eq 3 ] || [ "$#" -eq 2 ]
then
    if [ "$#" -eq 2 ]; then interface=eno1; else interface="$3"; fi                         # tshark listens on eth0 by default -> hand over $interface if changed 
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi                             # check for leading '0'
    for ((container = 1; container <= "$2"; container++))
    do
        if [ "$container" -lt 10 ]; then container_=0"$container"; else container_="$container"; fi        # check for leading '0'
        echo "[$0] $(date) - STEP: add IP to container $container_"
        sudo lxc config device add lvl"$level_"-c"$container_" "$interface" nic nictype=bridged parent=lvlbr"$level_" name="$interface" 
        sudo lxc exec lvl"$level_"-c"$container_" -- ip addr add 10.10."$1"."$container"/24 dev "$interface" 
        sudo lxc exec lvl"$level_"-c"$container_" -- ip link set dev "$interface" up 
    done
    echo "[$0] $(date) - STEP: try target container" 
    sudo lxc config device add lvl"$level_"-target "$interface" nic nictype=bridged parent=lvlbr"$level_" name="$interface" 
    sudo lxc exec lvl"$level_"-target -- ip addr add 10.10."$1".0/24 dev "$interface" 
    sudo lxc exec lvl"$level_"-target -- ip link set dev "$interface" up 
    echo "[$0] $(date) - DONE: added network to containers for level $1" 
else
    echo "[$0] $(date) - FAIL: invalid number of parameters" 
fi
