#!/bin/bash
# start a tmux-session and all windows for level 02


cd $(dirname "$0")
clear ; echo -e "\nyou chose level 2. starting..."
(level_start.sh 2 3 &)                                                      # containers getting started
./storytime.sh                                                                # story time :)

lxc config set lvl02-c01 volatile.eno1.hwaddr 00:00:00:00:00:11
#lxc restart lvl02-c01
lxc config set lvl02-c02 volatile.eno1.hwaddr 00:00:00:00:00:22
#lxc restart lvl02-c02
lxc config set lvl02-c03 volatile.eno1.hwaddr 00:00:00:00:00:33


./../../backend/container_ip_add.sh 2 3                                                                            # create the session and two split pane
tmux new-session -s hacklab -n level02 -d 'lxc exec lvl02-c02 -- ping 10.10.2.3; bash -i'\;\
   split-window -v -d 'lxc shell lvl02-c01'\;\
   split-window -h -d 'lxc shell lvl02-c03' \;\
  select-pane -D

tmux new-window -t hacklab:1 -n help 'print_paragraph_from_file text_3 ./story.txt;  bash -i'           # create a new window and run

tmux select-window -t hacklab:1                                             # select the window who will start at first

tmux -2 attach-session -t hacklab                                           # to attach the session

clear ; ./evaluation.sh                                                     # evaluation of the level
sleep 3
cd - > /dev/null
