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

# basic script to start a whole level
# $1 = level
# $2 = number of containers
# future: $3 = optional ISO fingerprint

echo "[$0] $(date) - CALL: level: $1 - containers: $2 - ISO: $3"
# print everything into ./logs/level_start.log
cd $(dirname "$0"); mkdir -p logs;
LOGFILE=$( basename "$0" | sed s\#'^'\#'\./logs/'\# | sed s\#'\.sh'\#'\.log'\# ); exec &>>"$LOGFILE"
#LOGFILE=$( echo "$0" | sed s\#'\.sh'\#'\.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ); exec &>> "$LOGFILE"

# to do: check for more complex calls (number of parameters)
if [ "$#" -eq 2 ]
then
    echo "[$(basename "$0")] $(date) - STEP: add bridge";       ./bridge_add.sh "$1";           wait $!
    echo "[$(basename "$0")] $(date) - STEP: init containers";  ./container_create.sh "$1" "$2";wait $!
    echo "[$(basename "$0")] $(date) - STEP: start containers"; ./container_start.sh "$1" "$2"; wait $!
    echo "[$(basename "$0")] $(date) - STEP: add network IPs";  ./container_ip_add.sh "$1" "$2";wait $!
    echo -n "[$(basename "$0")] $(date) - STEP: return to path: "; cd -
    echo "[$(basename "$0")] $(date) - DONE: started level $1 with $2 containers"
else
    echo "[$0] $(date) - FAILED: invalid number of parameters"
fi