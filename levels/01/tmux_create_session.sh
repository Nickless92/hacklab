#!/bin/bash
# start a tmux-session and all windows for level 01 

cd $(dirname "$0")
clear ; echo -e "\nyou chose level 1. starting..."
(../../backend/level_start.sh 1 3 &)                                        # containers getting started
./storytime.sh                                                              # story time :)
sleep 5                                                                     # the user gets some time to read the task
#sudo lxc exec lvl01-c01 -- touch command.txt                               # create a file where the user has to save his/her command

clear

lxc exec lvl01-c02 -- tshark -i eno1 &>> ausgabe.log & 
                                                                            # create the session and two split pane
tmux new-session -s hacklab -n level01 -d 'lxc exec lvl01-c02 -- tshark -i eno1; bash -i'\;\
    split-window -v -d 'lxc shell lvl01-c01'\;\
    split-window -h -d 'lxc exec lvl01-c03 -- tshark -i eno1' \;\
    select-pane -D

tmux new-window -t hacklab:1 -n help 'cat ./levels/01/story.txt; bash -i'               # create a new window and run

tmux select-window -t hacklab:1                                             # select the window who will start at first

tmux -2 attach-session -t hacklab                                           # to attach the session

clear
. ./levels/01/finish.sh                                                               # evaluation of the level
sleep 3
cd - > /dev/null
