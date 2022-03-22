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

function cd_return {
    echo -n "[$(basename "$0")] DONE: return to path: "; cd -                                       # cd to former working dir
}
trap cd_return EXIT                                                                                 # trap 'exit', run cd_return first

cd $(dirname "$0") ; . ./log_with_timestamp.sh                                                      # cd to path/to/$0, call log_with_timestamp.sh
echo "[$(basename "$0")] CALL: $@"

if [ $# = 2 ]                                                                                       # only two parameters allowed
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi                                       # adjust for two-digit number sheme
    for((container = 1; container <= $2; container++)); do
        if [ "$container" -lt 10 ]; then container_=0"$container"; else container_="$container"; fi
        echo "[$(basename "$0")] STEP: delete container $container_"
        lxc delete lvl"$level"-c"$container_"                                                       # deletes a container (only if STOPPED)
    done
    echo "[$(basename "$0")] STEP: try target container"
    lxc delete lvl"$level"-target                                                                   # in case there is a target VM - FIXME: catch this
    echo "[$(basename "$0")] DONE: deleted containers for level $1"
    exit 0
else
    echo "[$(basename "$0")] FAIL: invalid number of parameters"
    exit 1
fi
