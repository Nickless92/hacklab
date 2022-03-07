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

# script to delete a lxd network bridge
# $1 = level

cd $(dirname "$0") ; . ./log.sh
echo "[$(basename "$0")] CALL: level: $1"

if [ $# = 1 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    sudo ip link set dev lvlbr$level down        # stops and deletes the L2 link $1
    sudo brctl delbr lvlbr$level                 # stops and deletes bridge named $1
    echo "[$(basename "$0")] STEP: delete bridge $level"
    echo "[$(basename "$0")] DONE: deleted bridge for level $1"
else
    echo "[$(basename "$0")] FAIL: invalid number of parameters"
fi
