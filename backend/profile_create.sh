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

# create a lxd profile
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
    lxc profile show "$name" > /dev/null || echo "[$(basename "$0")] FAIL: profile $name doesn't exist."    # probe for $name's existence
    # # # nothing between 'lxc network show' and 'if' statement # # #
    if [ $? = 0 ]; then                                                         # only if network $name doesn't exist already
        echo "[$(basename "$0")] DONE: network $name already exists!"; exit 0
    else
        echo "[$(basename "$0")] STEP: create profile $name"
        lxc profile create $name                                                # create a lxc bridge
        cat ../ressources/lxc_profile_config.yml | lxc profile edit $name       # get config from .yml file
        echo "[$(basename "$0")] DONE: created profile $name"
        exit 0
    fi
else
    echo "[$(basename "$0")] FAIL: invalid number of parameters"
    exit 1
fi
