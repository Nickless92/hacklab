#!/bin/bash

end=5

for ((counter = 1; counter <= end; counter++))
do
	if [ $counter -lt 10 ]
	then
        sudo ip link set dev lvlbr0"$counter" down
        sudo brctl delbr lvlbr0"$counter"
	else
        sudo ip link set dev lvlbr"$counter" down
        sudo brctl delbr lvlbr"$counter"
	fi
done