#!/bin/bash
# start a tmux-session and all windows for level 02


cd $(dirname "$0")
clear ; echo -e "\nyou chose level 2. starting..."
(level_start.sh 2 3 &)                                                      # containers getting started
./storytime.sh                                                              # story time :)

                                                                            # create the session and two split pane
tmux new-session -s hacklab -n level02 -d 'lxc exec lvl02-c02 -- ping 10.10.2.3; bash -i'\;\
   split-window -v -d 'lxc shell lvl02-c01'\;\
   split-window -h -d 'lxc exec lvl02-c03 -- tcpdump -w opfer.txt' \;\
  select-pane -D

tmux new-window -t hacklab:1 -n help 'print_paragraph_from_file text_3 ./story.txt;  bash -i'           # create a new window and run

tmux select-window -t hacklab:1                                             # select the window who will start at first

tmux -2 attach-session -t hacklab                                           # to attach the session

clear ; ./evaluation.sh                                                     # evaluation of the level
sleep 3
cd - > /dev/null
