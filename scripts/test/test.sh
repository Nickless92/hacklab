#!/bin/bash

# print everything into ./logs/SCRIPT.log
LOGFILE=$(echo "$0" | sed s\#'.sh$'\#'.log'\# | sed s\#'^./'\#'./logs/'\# ); exec &>> "$LOGFILE"
echo "[$0] *** $(date) ***"; echo "[$0] level = $1 - devices = $2"