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

# script to stop containers of a level
# $1 = level
# $2 = number of containers

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'\.log'\# | sed s\#'^.*/'\#'./logs/'\# ); exec &>> "$LOGFILE"
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'\.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ); exec &>> "$LOGFILE"
echo "[$0] $(date) - CALL: level: $1 - containers: $2"

if [ $# = 2 ]
then
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi
    for((container = 1; container <= "$2"; container++))                         # cycle through all containers of a level
    do
        if [ "$container" -lt 10 ]; then container_=0"$container"; else container_="$container"; fi
        echo "[$0] $(date) - STEP: stop container $container_"
        sudo lxc stop lvl"$level_"-c"$container_"            # only STOPS the given lxc container
    done
    echo "[$0] $(date) - STEP: try target container"
    sudo lxc stop lvl"$level_"-target                     # in case there is a TARGET container
    echo "[$0] $(date) - DONE: stopped containers for level $1" 
else
    echo "[$0] $(date) - FAIL: invalid number of parameters" ;
fi
