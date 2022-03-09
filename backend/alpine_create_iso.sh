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

# create an up-to-date alpine iso with useful tools for hacklab

cd $(dirname "$0") ; . ./log_with_timestamp.sh ; echo "Done: changed into $(pwd)"

# $timestamp: fetch iso creation time, $timelimit: add 24 hours (1h = 3600s) - date() takes care of timezones
timestamp=$( lxc image info iso-alpine-utils | grep Created | date -d "$(sed s/'^.*: '/''/)" +%s )
timelimit=$(( $timestamp + 3600*24 ))
# check if creating a new build is necessary (age > 24 hours) or forced by user
if [ "$1" != "force" ] && [ $(date +%s) -lt "$timelimit" ]
    then echo "[$(basename "$0")] DONE: iso-alpine-utils still up-to-date. READY!"; exit 0; fi
# else, continue

# first, make sure to delete an existing alpine-runner container
lxc delete alpine-runner --force
# second, make sure to delete existing iso-alpine-stage/-edge images
lxc image delete iso-alpine-stage
# third, only copy alpine/edge from images if necessary (age > 24 hours) or forced by user
# $timestamp: fetch iso upload time, $timelimit: add 24 hours (1h = 3600s) - date() takes care of timezones
timestamp2=$( lxc image info iso-alpine-edge | grep Uploaded | date -d "$(sed s/'^.*: '/''/)" +%s )
timelimit2=$(( $timestamp2 + 3600*24 ))
if [ "$1" = "force" ] && [ "$2" = "purge" ] && [ $(date +%s) -lt "$timelimit2" ]
    then lxc image delete iso-alpine-edge
    echo "[$(basename "$0")] DONE: deleted stale iso-alpine-edge."
    else
    echo "[$(basename "$0")] DONE: iso-alpine-edge up-to-date. Continue."; fi
echo "[$(basename "$0")] DONE: purged leftovers"

# create container alpine-runner with image alpine/edge
lxc image copy images:alpine/edge local: --alias iso-alpine-edge
lxc init iso-alpine-edge alpine-runner
lxc start alpine-runner
#lxc launch images:alpine/edge alpine-runner # shorthand
echo "[$(basename "$0")] DONE: started alpine-runner with alpine/edge image"

# config lxdbr0 to provide internet access via DHCP
sudo lxc network set lxdbr0 ipv4.dhcp=true
echo "[$(basename "$0")] DONE: hacklab bridge: set ipv4.dhcp true"

# install packages
lxc file push ./alpine_install_tools.sh alpine-runner/root/install_tools
echo "[$(basename "$0")] DONE: push alpine_install_tools.sh in alpine-runner"
lxc exec alpine-runner -- ./install_tools ; wait 10 # FIXME: $! stopped working??
echo "[$(basename "$0")] DONE: tools installed in alpine-runner"
lxc file pull alpine-runner/root/log ./logs/alpine_install_tools.log
lxc exec alpine-runner -- rm -rf /var/log/
lxc exec alpine-runner -- rm -rf /tmp/
lxc exec alpine-runner -- rm -f /root/install_tools
lxc exec alpine-runner -- rm -f /root/log
echo "[$(basename "$0")] DONE: pull + purge logs from alpine-runner"

# config lxdbr0 to stop DHCP service
sudo lxc network set lxdbr0 ipv4.dhcp=false
echo "[$(basename "$0")] DONE: hacklab bridge: set ipv4.dhcp false"

# snapshot and export image as ISO
lxc snapshot alpine-runner alpine-snap
lxc publish alpine-runner/alpine-snap --alias iso-alpine-stage
echo "[$(basename "$0")] DONE: snapshot + publishing as ISO"

# stop and delete alpine-runner, then check if iso-alpine-stage exists
lxc stop alpine-runner
lxc delete alpine-runner
lxc image delete iso-alpine-edge
echo "[$(basename "$0")] DONE: purged alpine-runner and iso-alpine-edge"
lxc image show iso-alpine-stage
## NO COMMANDS BETWEEN HERE AND IF [ $? -eq 0 ] ##

# overwrite iso-alpine-utils only if iso-alpine-stage exists
if [ $? -eq 0 ]
then
    echo "[$(basename "$0")] DONE: iso-alpine-stage successfully created"
    lxc image delete iso-alpine-utils
    echo "[$(basename "$0")] DONE: purged stale iso-alpine-utils"
    lxc image alias rename iso-alpine-stage iso-alpine-utils
    echo "[$(basename "$0")] DONE: renamed in iso-alpine-utils - READY!"
else
    echo "[$(basename "$0")] FAIL: NO iso-alpine-stage AVAILABLE"
fi

echo -n "[$(basename "$0")] DONE: return to path: "; cd -
