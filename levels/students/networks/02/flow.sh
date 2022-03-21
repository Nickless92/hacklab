#!/bin/bash

module=networks
level=02

cd $(dirname "$0")
PATH=$PATH:$(dirname "$0")
echo -e "\nyou chose level $level. starting..."
(level_start.sh $level 3 &)                 # initiate level infrastructure

storytime.sh                                # story time :)
tmux_session.sh; clear                      # <- actual gameplay - create different windows
. evaluation.sh                             # evaluation of the level
allow_retry.sh                              # allows user to play again without destructing containers
. upload_score_to_database $module $level   # upload + authentication, 1 = level

#end tmux session                            # clean up
(level_stop.sh $level 3 &)                  # remove level infrastructure

exit 0
