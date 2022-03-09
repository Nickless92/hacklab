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
    echo -n "[$(basename "$0")] DONE: return to path: "; cd -
}
trap cd_return EXIT

cd $(dirname "$0") ; . ./log_with_timestamp.sh
echo "[$(basename "$0")] CALL: level: $1 - containers: $2 - ISO: $3"

# to do: check for more complex calls (number of parameters)
if [ "$#" -eq 2 ]
then
    echo "[$(basename "$0")] STEP: create network";     ./network_create.sh
    echo "[$(basename "$0")] STEP: init containers";    ./container_create.sh "$1" "$2"
    echo "[$(basename "$0")] STEP: start containers";   ./container_start.sh  "$1" "$2"
    echo "[$(basename "$0")] STEP: add network IPs";    ./container_ip_add.sh "$1" "$2"
    echo -n "[$(basename "$0")] STEP: return to path: "; cd -
    echo "[$(basename "$0")] DONE: started level $1 with $2 containers"
    exit 0
else
    echo "[$(basename "$0")] FAILED: invalid number of parameters: $#"
    exit 1
fi