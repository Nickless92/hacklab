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
# future: $3 = interface (optional)

function cd_return {
    echo -n "[$(basename "$0")] DONE: return to path: "; cd -                               # cd to former working dir
}
trap cd_return EXIT                                                                         # trap 'exit', run cd_return first

cd $(dirname "$0") ; . ./log_with_timestamp.sh                                              # cd to path/to/$0, 'source' log_with_timestamp.sh
echo "[$(basename "$0")] CALL: $@"

if [ "$#" -eq 2 ] ; then                                                                    # only two parameters allowed - much simpler call than level_start.sh
    echo "[$(basename "$0")] STEP: delete network IPs";   ./container_ip_del.sh "$1" "$2"   # remove ips...
    echo "[$(basename "$0")] STEP: stop containers";      ./container_stop.sh "$1" "$2"     # stop ...
    echo "[$(basename "$0")] STEP: delete containers";    ./container_delete.sh "$1" "$2"   # delete ...
    echo "[$(basename "$0")] DONE: stopped level $1 with $2 containers"                     # ... done!
    exit 0                                                                                  # left-overs: network and profile, ready for next level
else
    echo "[$(basename "$0")] FAILED: invalid number of parameters"
    exit 1
fi