#!/bin/bash

for ((counter = 1; counter <= 15; counter++))
do
	if [ $counter -lt 10 ]
	then
		#echo  "then"
		#echo "$counter"
		lxc delete level0"$counter" --force
	else
		#echo "else"
		#echo "$counter"
		lxc delete level"$counter" --force
	fi
done