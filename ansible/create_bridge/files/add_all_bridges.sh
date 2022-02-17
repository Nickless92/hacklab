#!/bin/bash

levelend=5

for ((level = 1; level <= levelend; level++))
do
	if [ $level -lt 10 ]
	then
        sudo brctl addbr lvlbr0"$level" up
        sudo ip link set dev lvlbr0"$level" up
	else
        sudo brctl addbr lvlbr"$level" up
        sudo ip link set dev lvlbr"$level" up
	fi
done