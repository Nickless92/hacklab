#!/bin/bash
#script to start a tmux-session and all windows for the level01 

clear ; echo -e "\nyou chose level 1. starting..." ; 
(../scripts/level_start.sh 1 3 &) ;                                         #containers getting started
../levels/01-test/netlvl_1.sh ;                                                             #story time :)
../levels/01-test/netlvl_1_explanation.sh ;                                                 #explanation for the level
sleep 10 ;                                                                  #the user gets some time to read the task
sudo lxc exec lvl01-c01 -- touch command.txt ;                              #creates a file in the container where the user has to save his/her command

#create the  session and two split pane
tmux new-session -s hacklab -n level01 -d 'lxc exec lvl01-c02 -- tshark -i eth0; bash -i'\; split-window -v -d 'lxc shell lvl01-c01'\; split-window -h -d 'lxc exec lvl01-c03 -- tshark -i eth0' \; select-pane -D

#create a new window and run 
tmux new-window -t hacklab:1 -n help 'ls -l; bash -i'

#select the window who will start at first
tmux select-window -t hacklab:0

#to attach the session
tmux -2 attach-session -t hacklab

clear ; 
../levels/01-test/finish.sh ;                                                               #evaluation of the level
sleep 3 ;