#!/bin/bash
#script to start a tmux-session and all windows for the level01 

#create the  session and two split pane
tmux new-session -s hacklab -n level01 -d 'lxc exec lvl01-c02 -- tshark -i eno1 > ausgabe.txt; bash -i'\; split-window -v -d 'lxc shell lvl01-c01'\; split-window -h -d 'lxc exec lvl01-c03 -- tshark -i eno1' \; select-pane -D

#create a new window and run 
tmux new-window -t hacklab:1 -n help 'ls -l; bash -i'


#select the window who will start at first
tmux select-window -t hacklab:0

#to attach the session
tmux -2 attach-session -t hacklab
