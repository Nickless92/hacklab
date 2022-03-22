#!/bin/bash
# start a tmux-session and all windows for level 01 

lxc exec lvl01-c02 -- tshark -i eno1 &>> ausgabe.log &

# create the session and two split pane
tmux new-session -s hacklab -n level01 -d 'lxc exec lvl01-c02 -- tshark -i eno1; bash -i'\;\
    split-window -v -d 'lxc shell lvl01-c01'\;\
    split-window -h -d 'lxc exec lvl01-c03 -- tshark -i eno1' \;\
    select-pane -D

tmux new-window -t hacklab:1 -n help 'print_paragraph_from_file synopsis ./story.txt; bash -i'   # create a new window and run
tmux new-window -t hacklab:2 -n topology 'cat topology.txt; bash -i'                             # create a new window and run
tmux select-window -t hacklab:1                                                 # select the window who will start at first
tmux -2 attach-session -t hacklab > /dev/null                                   # to attach the session

lxc exec lvl01-c02 -- killall tshark; sleep 1                                   # wait long enough kill tshark