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

# set up given number of containers of a level (stopped, not running)
# $1 = level
# $2 = number of containers
# $3 = optional: fingerprint of ISO [default = alpine-iso-utils]

function cd_return {
    echo -n "[$(basename "$0")] DONE: return to path: "; cd -
}
trap cd_return EXIT

cd $(dirname "$0") ; . ./log_with_timestamp.sh
echo "[$(basename "$0")] CALL: level: $1 - containers: $2 - ISO: $3"

if [ "$#" -eq 3 ] || [ "$#" -eq 2 ]
then
    #if [ "$#" -eq 2 ]; then image=5dd7ed85ba21; else image="$3"; fi
    if [ "$#" -eq 2 ]; then image="iso-alpine-utils"; else image="$3"; fi
    if [ "$1" -lt 10 ]; then level_=0"$1"; else level_="$1"; fi                             # check for leading '0'
    for (( container=1; container <= "$2"; container++ ))
    do
        if [ "$container" -lt 10 ]; then container_=0"$container"; else container_="$container"; fi        # check for leading '0'
        echo "[$(basename "$0")] STEP: init container $container_"
        lxc init -p hacklab "$image" lvl"$level_"-c"$container_" 
    done
    echo "[$(basename "$0")] DONE: created containers for level $level"
    exit 0
else
    echo "[$(basename "$0")] FAIL: invalid number of parameters"
    exit 1
fi