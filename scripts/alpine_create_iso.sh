#!/bin/bash
# script to create an up-to-date alpine iso with useful tools for hacklab

# print everything into ./logs/SCRIPT.log, if no permissions for /var/log/ 
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'./logs/'\# ); exec &>> "$LOGFILE"
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ); exec &>> "$LOGFILE"

# $timestamp: fetch iso creation time, $timelimit: add 1 hour (3600s) - date() takes care of timezones
timestamp=$( sudo lxc image info iso-alpine-utils | grep Created | date -d "$(sed s/'^.*: '/''/)" +%s )
timelimit=$(( $timestamp + 3600 ))
# check if creating a new build is necessary (age > 1 hour) or forced by user
if [ "$1" != "force" ] && [ $(date +%s) -lt "$timelimit" ]; then echo "[$0] $(date) - DONE: ISO up-to-date. READY!"; exit 0; fi

# first, make sure to delete an existing alpine-runner container
sudo lxc delete alpine-runner --force
# second, make sure to delete existing iso-alpine-stage/-edge images
sudo lxc image delete iso-alpine-stage
sudo lxc image delete iso-alpine-edge
echo "[$0] $(date) - DONE: purged leftovers"

# create container alpine-runner with image alpine/edge
sudo lxc image copy images:alpine/edge local: --alias iso-alpine-edge
sudo lxc init iso-alpine-edge alpine-runner
sudo lxc start alpine-runner
echo "[$0] $(date) - DONE: started alpine-runner with alpine/edge image"

# config lxdbr0 to provide internet access via DHCP
sudo lxc network set lxdbr0 ipv4.dhcp=true

# install packages
sudo lxc file push ./alpine_install_tools.sh alpine-runner/root/install_tools.sh
echo "[$0] $(date) - DONE: push alpine_install_tools.sh in alpine-runner"
sudo lxc exec alpine-runner -- ./install_tools.sh; wait $!
echo "[$0] $(date) - DONE: tools installed in alpine-runner"
sudo lxc file pull alpine-runner/root/install_tools.log ./logs/install_tools.log
sudo lxc exec alpine-runner -- rm -r /var/log/
sudo lxc exec alpine-runner -- rm -f /root/install_tools\.*
sudo lxc exec alpine-runner -- rm -r /tmp/
echo "[$0] $(date) - DONE: pull + purge logs from alpine-runner"

# config lxdbr0 to stop DHCP service
sudo lxc network set lxdbr0 ipv4.dhcp=false

# snapshot and export image as ISO
sudo lxc snapshot alpine-runner alpine-snap
sudo lxc publish alpine-runner/alpine-snap --alias iso-alpine-stage
echo "[$0] $(date) - DONE: snapshot + publishing as ISO"

# stop and delete alpine-runner, then check if iso-alpine-stage exists
sudo lxc stop alpine-runner
sudo lxc delete alpine-runner
sudo lxc image delete iso-alpine-edge
echo "[$0] $(date) - DONE: purged alpine-runner and iso-alpine-edge"
sudo lxc image show iso-alpine-stage
## NO COMMANDS BETWEEN HERE AND IF [ $? -eq 0 ] ##

# if iso-alpine-stage exists, overwrite iso-alpine-utils
if [ $? -eq 0 ]
then
    echo "[$0] $(date) - DONE: iso-alpine-stage successfully created"
    sudo lxc image delete iso-alpine-utils
    echo "[$0] $(date) - DONE: purged stale iso-alpine-utils"
    sudo lxc image alias rename iso-alpine-stage iso-alpine-utils
    echo "[$0] $(date) - DONE: renamed in iso-alpine-utils - READY!"
else
    echo "[$0] $(date) - FAIL: NO iso-alpine-stage AVAILABLE"
fi
