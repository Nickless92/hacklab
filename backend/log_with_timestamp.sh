#!/bin/bash

# suppress stdout+errout from backend scripts
# instead, use them as logs with timestamps prepended
# creates a seperate .log file for each script

mkdir -p logs                                                                                   # check if dir logs/ exists, otherwise create it
LOGFILE=$( basename "$0" | sed s\#^\#'\./logs/'\# | sed s\#'\.sh'\#''\# | sed s\#$\#'\.log'\# ) # set LOGFILE to ./logs/FILENAME with FILENAME = $0.log
#LOGFILE=$(echo "$0" | sed s\#'\.sh'\#'\.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# )        # try logging in system dir /var/log/ - non-functional without sudo
#exec &>> "$LOGFILE"                                                                            # (too) simple output redirection
exec 3>&1                                                                                       # link fd #3 with stdout
exec > >(gawk '{ print strftime("[%Y-%m-%d %H:%M:%S]"), $0 ; fflush(stdout) }' \
| sed s/']'/" - $$]"/ &>> "$LOGFILE") 2>&1                                                      # redirect output with timestamps, flushing stdout to get continuous output