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

# script to delete containers for a level (if stopped)
# $1 = level
# $2 = number of containers

# print everything into ./logs/SCRIPT.log
echo "[$0] $(date) - CALL: level: $1 - containers: $2"
cd $(dirname "$0"); mkdir -p logs;
LOGFILE=$( basename "$0" | sed s\#'^'\#'\./logs/'\# | sed s\#'\.sh'\#'\.log'\# ); exec &>>"$LOGFILE"
#LOGFILE=$(echo "$0" | sed s\#'\.sh'\#'\.log'\# | sed s\#'^.*/'\#'./logs/'\# ); exec &>> "$LOGFILE"
#LOGFILE=$(echo "$0" | sed s\#'\.sh'\#'\.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ); exec &>> "$LOGFILE"

if [ $# = 2 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    for((container = 1; container <= $2; container++))
    do
        if [ "$container" -lt 10 ]; then container_=0"$container"; else container_="$container"; fi
        echo "[$0] $(date) - STEP: delete container $container_"
        sudo lxc delete lvl"$level"-c"$container_"   # deletes a stopped container
    done
    echo "[$0] $(date) - STEP: try target container" 
    sudo lxc delete lvl"$level"-target            # in case there is a target VM
    echo "[$0] $(date) - DONE: deleted containers for level $1" 
else
    echo "[$0] $(date) - FAIL: invalid number of parameters" 
fi
