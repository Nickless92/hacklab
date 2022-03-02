#!/bin/bash
# script to create an up-to-date alpine iso with useful tools for hacklab

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'./logs/'\# ); exec &>> "$LOGFILE"
LOGFILE=$(echo "$0" | sed s\#'.sh'\#'.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ); exec &>> "$LOGFILE"
echo "[$0] $(date) - CALL: level: $1"

# create container with alpine/edge
sudo lxc image copy images:alpine/edge local: --alias iso-edge
sudo lxc init iso-edge alpine-runner
sudo lxc start alpine-runner

# add internet - unnecessary due to bridge config
#sudo lxc config device add alpine-edge eth0 nic nictype=bridged parent=lxdbr0 name="eth0"
#sudo lxc exec alpine-edge -- ip addr add 10.0.0.1/24 dev "eth0" 
#sudo lxc exec alpine-edge -- ip link set dev "eth0" up 

# install packages
sudo lxc file push ./alpine_install_tools.sh alpine-runner/root/install_tools.sh
echo "[$0] wait for iso-alpine-install.sh"
sudo lxc exec alpine-runner -- ./install_tools.sh; wait $!
echo "[$0] done with iso-alpine-install.sh"

# snapshot and export image as ISO
sudo lxc snapshot alpine-edge alpine-utils
sudo lxc publish alpine-edge/alpine-utils --alias iso-alpine-utils