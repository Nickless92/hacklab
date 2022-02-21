#!/bin/bash

deviceend=3

for((device = 1; device <= deviceend; device++))    # cycle through all devices of a level
do
    lxc stop lvl"$1"-d"$device"      # only STOPS the given lxc container
done
