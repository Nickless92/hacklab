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

function cd_return {
    echo -n "[$(basename "$0")] DONE: return to path: "; cd -
}
trap cd_return EXIT

cd $(dirname "$0") ; . ./log_with_timestamp.sh
echo "[$(basename "$0")] CALL: $@"

if [ $# = 0 ] || [ $# = 1 ]
then
    if [ $# = 0 ]; then name=hacklab; else name="$1"; fi                        # default: hacklab - FIXME: configurable name
    lxc network show "$name" > /dev/null                                        # probe for $name's existence
    # # # nothing between 'lxc network show' and 'if' statement # # #
    if [ "$?" = 0 ]                                                             # only if network $name doesn't exist already
        then echo "[$(basename "$0")] DONE: network $name already exists!"; exit 0
        else
            echo "[$(basename "$0")] STEP: create network $name"
            lxc network create "$name"                                          # create a lxc bridge \
            ipv4.address=10.10.0.1/24   ipv4.dhcp=true  ipv4.nat=true           # IPv4: dhcp hands out IPs if none provided manually  \
            ipv6.address=none           ipv6.dhcp=false ipv6.nat=false          # IPv6: generally disabled - FIXME: still, containers get a IPv6 link address \
            echo "[$(basename "$0")] DONE: created network $name"
            exit 0
    fi
else
    echo "[$(basename "$0")] FAIL: invalid number of parameters"
    exit 1
fi
