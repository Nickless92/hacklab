#!/bin/bash

deviceend=3

for((device = 1; device <= deviceend; device++))
do
    lxc stop lvl"$1"-d"$device"
done
