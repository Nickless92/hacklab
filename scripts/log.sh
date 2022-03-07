# check if dir logs/ exists, otherwise create it:
mkdir -p logs
# set LOGFILE to ./logs/FILENAME with FILENAME = $0.log
LOGFILE=$( basename "$0" | sed s\#'^'\#'\./logs/'\# | sed s\#'\.sh'\#'\.log'\# )
# try logging in system dir /var/log/ - non-functional without sudo: 
#LOGFILE=$(echo "$0" | sed s\#'\.sh'\#'\.log'\# | sed s\#'^.*/'\#'/var/log/hacklab/'\# ) 
# (too) simple output redirection:
#exec &>> "$LOGFILE"
# redirect output with timestamps, flushing stdout to get continuous output
PID=$!
exec > >(gawk '{ print strftime("[%Y-%m-%d %H:%M:%S]"), $0 ; fflush(stdout) }' | sed s/']'/" - $$]"/ &>> "$LOGFILE") 2>&1