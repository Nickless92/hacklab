#!/bin/bash

deviceend=3

for((device = 1; device <= deviceend; device++))
do
done
    lxc delete lvl"$1"-d"$device"    # deletes a stopped container
    lxc delete lvl"$1"-target        # in case there is a target VM
echo "deleted containers for level $1"
