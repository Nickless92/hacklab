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

# connect given number of containers to network bridge 'hacklab' (via given interface) 
# $1 = level
# $2 = number of containers
# $3 = interface [default = eno1]

function cd_return {
    echo -n "[$(basename "$0")] DONE: return to path: "; cd -                                                                   # cd to former working dir
}
trap cd_return EXIT                                                                                                             # trap 'exit', run cd_return first

cd $(dirname "$0") ; . ./log_with_timestamp.sh                                                                                  # cd to path/to/$0, call log_with_timestamp.sh
echo "[$(basename "$0")] CALL: $@"

if [ "$#" -eq 3 ] || [ "$#" -eq 2 ]                                                                                             # only two or three parameters allowed
then
    if [ "$#" -eq 2 ]; then interface=eno1; else interface="$3"; fi                                                             # default $interface = eno1
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi                                                                 # adjust for two-digit number sheme
    for ((container = 1; container <= "$2"; container++)); do
        if [ "$container" -lt 10 ]; then container_=0"$container"; else container_="$container"; fi
        echo "[$(basename "$0")] STEP: add IP to container $container_"
        lxc config device add lvl"$level_"-c"$container_" "$interface" nic nictype=bridged parent=hacklab name="$interface"     # on host: add interface to container
        lxc exec lvl"$level_"-c"$container_" -- ip addr add 10.10."$1"."$container"/24 dev "$interface"                         # inside container: add ip address to device
        lxc exec lvl"$level_"-c"$container_" -- ip link set dev "$interface" up                                                 # inside container: change device state to 'up'
    done
    echo "[$(basename "$0")] STEP: try target container"                                                                        # in case there is a target VM - FIXME: catch this
    lxc config device add lvl"$level_"-target "$interface" nic nictype=bridged parent=hacklab name="$interface"
    lxc exec lvl"$level_"-target -- ip addr add 10.10."$1".0/24 dev "$interface" 
    lxc exec lvl"$level_"-target -- ip link set dev "$interface" up 
    echo "[$(basename "$0")] DONE: added network to containers for level $1"
    exit 0
else
    echo "[$(basename "$0")] FAIL: invalid number of parameters"
    exit 1
fi
