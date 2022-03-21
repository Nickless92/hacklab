#!/bin/bash

module=networks
level=1

cd $(dirname "$0")
PATH=$PATH:$(dirname "$0")
echo -e "\nyou chose level $level. starting..."
(level_start.sh $level 3 &)                 # initiate level infrastructure

./storytime.sh                              # story time :)
./tmux_session.sh; clear                    # <- actual gameplay - create different windows
. ./evaluation.sh                           # evaluation of the level
./allow_retry.sh
. upload_score_to_database $module $level   # upload + authentication, 1 = level

rm ausgabe.log                              # clean up
(level_stop.sh $level 3 &)                  # remove level infrastructure

exit 0