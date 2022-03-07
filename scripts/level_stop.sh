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

# basic script to stop a whole level
# $1 = level
# $2 = number of containers
# future: $3 = optional ISO fingerprint

cd $(dirname "$0") ; . ./log.sh
echo "[$(basename "$0")] CALL: level: $1 - containers: $2 - interface: $3"

# to do: check for more complex calls (number of parameters)
if [ "$#" -eq 2 ]
then
    echo "[$(basename "$0")] $(date) - STEP: delete network IPs";   ./container_ip_del.sh "$1" "$2";   wait $!
    echo "[$(basename "$0")] $(date) - STEP: stop containers";      ./container_stop.sh "$1" "$2";     wait $!
    echo "[$(basename "$0")] $(date) - STEP: delete containers";    ./container_delete.sh "$1" "$2";   wait $!
    echo "[$(basename "$0")] $(date) - STEP: delete bridge";        ./bridge_del.sh "$1";              wait $!
#    cd ../scripts/  # to make sure one is in /scripts/ folder
#    echo "[$(basename "$0")] $(date) - STEP: delete network IPs";   sudo ./container_ip_del.sh "$1" "$2";   wait $!
#    echo "[$(basename "$0")] $(date) - STEP: stop containers";      sudo ./container_stop.sh "$1" "$2";     wait $!
#    echo "[$(basename "$0")] $(date) - STEP: delete containers";    sudo ./container_delete.sh "$1" "$2";   wait $!
#    echo "[$(basename "$0")] $(date) - STEP: delete bridge";        sudo ./bridge_del.sh "$1";              wait $!
    echo -n "[$(basename "$0")] $(date) - STEP: return to path: "; cd -
    echo "[$(basename "$0")] $(date) - DONE: stopped level $1 with $2 containers"
else
    echo "[$(basename "$0")] $(date) - FAILED: invalid number of parameters"
fi