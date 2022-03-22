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

# start a whole level with given number of containers
# $1 = level
# $2 = number of containers

function cd_return {
    echo -n "[$(basename "$0")] DONE: return to path: "; cd -                               # cd to former working dir
}
trap cd_return EXIT                                                                         # trap 'exit', run cd_return first

cd $(dirname "$0") ; . ./log_with_timestamp.sh                                              # cd to path/to/$0, 'source' log_with_timestamp.sh
echo "[$(basename "$0")] CALL: $@"

if [ "$#" -eq 2 ] ; then                                                                    # only two parameters allowed - FIXME: check for more complex calls
    #echo "[$(basename "$0")] STEP: create network";     ./network_create.sh                 # creates lxc bridge "hacklab" (default name)
    echo "[$(basename "$0")] STEP: init containers";    ./container_create.sh "$1" "$2"     # creates $2 containers (stopped, with profile 'hacklab')
    echo "[$(basename "$0")] STEP: start containers";   ./container_start.sh  "$1" "$2"     # changes container state (stopped -> running)
    echo "[$(basename "$0")] STEP: add network IPs";    ./container_ip_add.sh "$1" "$2"     # adds network addresses (general sheme: 10.10.level.container/24)
    echo "[$(basename "$0")] DONE: started level $1 with $2 containers"                     # so only containers within a level can reach each other (net mask /24)
    exit 0
else
    echo "[$(basename "$0")] FAILED: invalid number of parameters: $#"
    exit 1
fi