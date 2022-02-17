#!/bin/sh

ip a | grep "global eth0" | sed 's/    inet //' | sed 's/\/.*//' > my_ip.txt

