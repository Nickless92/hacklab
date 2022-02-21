#!/bin/bash

for ((counter = 1; counter <= 15; counter++))
do
	if [ $counter -lt 10 ]   # check for leading '0'
	then
		#echo  "then"
		#echo "$counter"
		lxc start level0"$counter" 
	else
		#echo "else"
		#echo "$counter"
		lxc start level"$counter" 
	fi
done