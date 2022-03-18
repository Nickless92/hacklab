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

# tl;dr: create an up-to-date alpine iso with useful tools for hacklab

function cd_return {
    echo -n "[$(basename "$0")] DONE: return to path: "; cd -                                       # cd to former working dir
}
trap cd_return EXIT                                                                                 # trap 'exit', run cd_return first

cd $(dirname "$0") ; . ./log_with_timestamp.sh ; echo "Done: changed into $(pwd)"                   # cd to path/to/$0, call log_with_timestamp.sh

timestamp=$( lxc image info iso-alpine-utils | grep Created | date -d "$(sed s/'^.*: '/''/)" +%s )  # $timestamp: fetch iso creation time
timelimit=$(( $timestamp + 3600*24 ))                                                               # $timelimit: add 24 hours (1h = 3600s) - date() takes care of timezones
if [ "$1" != "force" ] && [ $(date +%s) -lt "$timelimit" ]                                          # check if (date > $timelimit) or update forced by user ('force')
    then echo "[$(basename "$0")] DONE: iso-alpine-utils still up-to-date. READY!"; exit 0; fi      # else, continue

lxc delete alpine-runner --force                                                                    # delete existing alpine-runner container
lxc image delete iso-alpine-stage                                                                   # delete existing iso-alpine-stage image
                                                                                                    # only copy alpine/edge from images if date or forced by user
timestamp2=$( lxc image info iso-alpine-edge | grep Uploaded | date -d "$(sed s/'^.*: '/''/)" +%s ) # $timestamp2: fetch iso upload time
timelimit2=$(( $timestamp2 + 3600*24 ))                                                             # $timelimit2: add 24 hours (1h = 3600s)
if [ "$1" = "force" ] && [ "$2" = "purge" ] || [ $(date +%s) -gt "$timelimit2" ]                    # check if (date > $timelimit2) or update forced by user ('force purge')
    then lxc image delete iso-alpine-edge
    echo "[$(basename "$0")] DONE: deleted stale iso-alpine-edge."
    else
    echo "[$(basename "$0")] DONE: iso-alpine-edge up-to-date. Continue."; fi
echo "[$(basename "$0")] DONE: purged leftovers"

lxc image copy images:alpine/edge local: --alias iso-alpine-edge                                    # copy alpine/edge from images: (if none in lxc images cache)
lxc init iso-alpine-edge alpine-runner                                                              # create container alpine-runner with image alpine/edge
lxc start alpine-runner
#lxc launch images:alpine/edge alpine-runner                                                         # shorthand
echo "[$(basename "$0")] DONE: started alpine-runner with alpine/edge image"

lxc file push ./alpine_install_tools.sh alpine-runner/root/install_tools                            # install packages as per install_tools.sh
echo "[$(basename "$0")] DONE: push alpine_install_tools.sh in alpine-runner"
lxc exec alpine-runner -- ./install_tools ; wait 10                                                 # wait for install_tools.sh - FIXME: '$!' stopped working??
echo "[$(basename "$0")] DONE: tools installed in alpine-runner"
lxc file pull alpine-runner/root/log ./logs/alpine_install_tools.log                                # pull logs from alpine-runner
lxc exec alpine-runner -- rm -rf /var/log/                                                          # some clean-up to reduce iso file size
lxc exec alpine-runner -- rm -rf /tmp/
lxc exec alpine-runner -- rm -f /root/install_tools
lxc exec alpine-runner -- rm -f /root/log
echo "[$(basename "$0")] DONE: pull + purge logs from alpine-runner"

lxc snapshot alpine-runner alpine-snap                                                              # snapshot and export image as ISO
lxc publish alpine-runner/alpine-snap --alias iso-alpine-stage
echo "[$(basename "$0")] DONE: snapshot + publishing as ISO"

lxc stop alpine-runner                                                                              # stop and delete alpine-runner/alpine-iso-edge
lxc delete alpine-runner
lxc image delete iso-alpine-edge
echo "[$(basename "$0")] DONE: purged alpine-runner and iso-alpine-edge"
lxc image show iso-alpine-stage                                                                     # check if alpine-iso-stage exists => return code = 0
## NO COMMANDS BETWEEN HERE AND IF [ $? -eq 0 ] ##

if [ $? -eq 0 ]                                                                                     # if successful, overwrite stale iso-alpine-utils
then
    echo "[$(basename "$0")] DONE: iso-alpine-stage successfully created"
    lxc image delete iso-alpine-utils
    echo "[$(basename "$0")] DONE: purged stale iso-alpine-utils"
    lxc image alias rename iso-alpine-stage iso-alpine-utils
    echo "[$(basename "$0")] DONE: renamed in iso-alpine-utils - READY!"
    exit 0
else                                                                                                # or indicate failure creating iso-alpine-stage
    echo "[$(basename "$0")] FAIL: NO iso-alpine-stage AVAILABLE"
    exit 1
fi
