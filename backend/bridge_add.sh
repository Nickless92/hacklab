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

# script to create a lxd network bridge
# $1 = level

cd $(dirname "$0") ; . ./log_with_timestamp.sh
echo "[$(basename "$0")] CALL: level: $1"
if [ $# = 1 ]
then
    if [ "$1" -lt 10 ]; then level=0"$1"; else level="$1"; fi
    echo "[$(basename "$0")] STEP: create bridge $level"
    sudo brctl addbr level$level up              # adds and starts a bridge named $1 
    sudo ip link set dev level$level up          # adds and starts the L2 link
    echo "[$(basename "$0")] DONE: created bridge for level $level"
else
    echo "[$(basename "$0")] FAIL: invalid number of parameters"
fi
