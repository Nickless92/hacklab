#!/bin/bash
# script to create an up-to-date alpine iso with useful tools for hacklab

# print everything into ./logs/SCRIPT.log, if no permissions for /var/log/ 
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'./logs/'\# ); exec &>> "$LOGFILE"
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ); exec &>> "$LOGFILE"

# first, make sure to delete an existing alpine-runner container
sudo lxc delete alpine-runner --force
# second, make sure to delete an existing alpine-iso-stage image
sudo lxc image delete alpine-iso-stage
echo "[$0] $(date) - DONE: purged leftovers"

# create container alpine-runner with image alpine/edge
sudo lxc image copy images:alpine/edge local: --alias iso-alpine-edge
sudo lxc init iso-alpine-edge alpine-runner
sudo lxc start alpine-runner
echo "[$0] $(date) - DONE: started alpine-runner with alpine/edge image"

# config lxdbr0 to provide internet access via DHCP
sudo lxc network set lxdbr0 ipv4.dhcp=true

# add internet - unnecessary due to bridge config
#sudo lxc config device add alpine-runner eth0 nic nictype=bridged parent=lxdbr0 name="eth0"
#sudo lxc exec alpine-runner -- ip addr add 10.0.0.1/24 dev "eth0"
#sudo lxc exec alpine-runner -- ip link set dev "eth0" up

# install packages
sudo lxc file push ./alpine_install_tools.sh alpine-runner/root/install_tools.sh
echo "[$0] $(date) - DONE: push alpine_install_tools.sh in alpine-runner"
sudo lxc exec alpine-runner -- ./install_tools.sh; wait $!
echo "[$0] $(date) - DONE: tools installed in alpine-runner"

# snapshot and export image as ISO
sudo lxc snapshot alpine-runner alpine-snap
sudo lxc publish alpine-runner/alpine-snap --alias iso-alpine-stage
echo "[$0] $(date) - DONE: snapshot + publishing as ISO"

# check if staging alpine-utils succeeded - if yes, overwrite iso-alpine-utils
if [ $(sudo lxc image show iso-alpine-stage) -eq 0 ]
then
    echo "[$0] $(date) - DONE: succesful test for iso-alpine-stage"
    sudo lxc image delete iso-alpine-utils
    echo "[$0] $(date) - DONE: purged iso-alpine-utils"
    sudo lxc image alias rename iso-alpine-stage iso-alpine-utils
    echo "[$0] $(date) - DONE: renamed in iso-alpine-utils - READY!"
else
    echo "[$0] $(date) - FAIL: NO iso-alpine-stage AVAILABLE"
fi
