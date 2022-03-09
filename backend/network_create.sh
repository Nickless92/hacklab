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
# $1 = name (optional - default: hacklab)

cd $(dirname "$0") ; . ./log.sh
echo "[$(basename "$0")] CALL: name: $1"

if [ $# = 0 ] || [ $# = 1 ]
then
    if [ $# = 0 ]; then name=hacklab; else name="$1"; fi
    echo "[$(basename "$0")] STEP: create network $name"
    [ "$(lxc network show "$name")" = 0 ] || lxc network create "$name" ipv4.address=none ipv4.dhcp=true ipv4.nat=true ipv6.address=none ipv6.dhcp=false ipv6.nat=false
    echo "[$(basename "$0")] DONE: network $name"
else
    echo "[$(basename "$0")] FAIL: invalid number of parameters"
fi
