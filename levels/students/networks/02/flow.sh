#!/bin/bash

module=networks
level=2

cd $(dirname "$0")
PATH=$PATH:$(dirname "$0")
echo -e "\nyou chose level $level. starting..."
(level_start.sh $level 3 &)                 # initiate level infrastructure

./storytime.sh                                # story time :)
lxc config set lvl02-c01 volatile.eth0.hwaddr 00:00:00:00:00:11
lxc restart lvl02-c01
lxc config set lvl02-c02 volatile.eth0.hwaddr 00:00:00:00:00:22
lxc restart lvl02-c02
lxc config set lvl02-c03 volatile.eth0.hwaddr 00:00:00:00:00:33
lxc restart lvl02-c03
container_ip_add.sh 2 3

./tmux_session.sh; clear                      # <- actual gameplay - create different windows
. ./evaluation.sh                             # evaluation of the level
./allow_retry.sh                              # allows user to play again without destructing containers
. upload_score_to_database $module $level   # upload + authentication, 1 = level

#end tmux session                            # clean up
(level_stop.sh $level 3 &)                  # remove level infrastructure

exit 0
