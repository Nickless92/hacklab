#!/bin/sh
# script to get a container's own IP

ip a | grep "global eth0" | sed 's/    inet //' | sed 's/\/.*//' > my_ip.txt
