#!/bin/bash

deviceend=3
levelend=2

for ((level = 1; level <= levelend; level++))
do
	for((device = 1; device <= deviceend; device++))
	do
		lxc stop lvl"$level"-d"$device"
	done
done