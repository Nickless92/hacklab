#!/bin/bash

echo -n "Do you want to play again? [Y|n]: "
read -n 1 choice
([ $choice = y ] || [ $choice = Y ]) && (./tmux_session.sh; clear; ./evaluation.sh)
exit 0
