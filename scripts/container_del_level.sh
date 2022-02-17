#!/bin/bash

deviceend=3

for((device = 1; device <= deviceend; device++))
do
    lxc delete lvl"$1"-d"$device"
done
