#!/bin/bash

for ((counter = 1; counter <= 15; counter++))
do
	if [ $counter -lt 10 ]
	then
		#echo  "then"
		#echo "$counter"
		lxc stop level0"$counter" 
	else
		#echo "else"
		#echo "$counter"
		lxc stop level"$counter" 
	fi
done