#!/bin/bash

for ((counter = 1; counter <= 15; counter++))
do
	if [ $counter -lt 10 ]     # checks need for leading '0'
	then
		#echo  "then"
		#echo "$counter"
		lxc delete level0"$counter" --force    # --force to delete a running container
	else
		#echo "else"
		#echo "$counter"
		lxc delete level"$counter" --force    # --force to delete a running container
	fi
done
