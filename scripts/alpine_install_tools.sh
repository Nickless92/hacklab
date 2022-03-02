#!/bin/sh
# script to update and install several tools for usage with hacklab 
# no bash available, hence /bin/sh

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/); exec >> "$LOGFILE" 2>&1

# update
echo "[$(date)] todo: update"
apk update
apk upgrade
echo "[$(date)] done: update"

# install git
echo "[$(date)] todo: git"
apk add git
echo "[$(date)] done: git"

# install lynis
echo "[$(date)] todo: lynis"
cd /usr/local/
git clone https://github.com/CISOfy/lynis
cd lynis/
ln -s /usr/local/lynis/lynis /bin/lynis
echo "[$(date)] done: lynis"

# purge git
echo "[$(date)] undo: git"
apk del git
echo "[$(date)] done: git"

# install MACchanger
echo "[$(date)] todo: macchanger"
apk add macchanger
echo "[$(date)] done: macchanger"

# install DNSrecon
echo "[$(date)] todo: dnsrecon"
apk add dnsrecon
echo "[$(date)] done: dnsrecon"

# install nmap
echo "[$(date)] todo: nmap"
apk add nmap
echo "[$(date)] done: nmap"

# install tmux
echo "[$(date)] todo: tmux"
apk add tmux
echo "[$(date)] done: tmux"

# install tshark
echo "[$(date)] todo: tshark"
apk add tshark
echo "[$(date)] done: tshark"

# install hping3
echo "[$(date)] todo: hping3"
apk add hping3
echo "[$(date)] done: hping3"

# install hping3
echo "[$(date)] todo: hping3 (testing)"
apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing hping3
echo "[$(date)] done: hping3 (testing)"

echo "[$(date)] DONE"
