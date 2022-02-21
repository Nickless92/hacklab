#!/bin/bash

# script to stop all containers
deviceend=3   # 3 containers per level
levelend=2    # 2 levels

for ((level = 1; level <= levelend; level++))
do
	for((device = 1; device <= deviceend; device++))
	do
		lxc stop lvl"$level"-d"$device"   # only STOPS the given lxc container
	done
done