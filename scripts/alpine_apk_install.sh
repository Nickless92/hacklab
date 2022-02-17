#!/bin/sh

# update
apk update
apk upgrade
echo "[done:] update"

# install git
apk add git
echo "[done:] git"

# install lynis
cd /usr/local/
git clone https://github.com/CISOfy/lynis
cd lynis/
ln -s /usr/local/lynis/lynis /bin/lynis
echo "[done:] lynis"

# install MACchanger
apk add macchanger
echo "[done:] macchanger"

# install DNSrecon
apk add dnsrecon
echo "[done:] dnsrecon"

# install nmap
apk add nmap
echo "[done:] nmap"

# install hping3
apk add hping3
echo "[done:] hping3"

# install tmux
apk add tmux
echo "[done:] tmux"

# install tshark
apk add tshark
echo "[done:] tshark"

# install hping3
apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing hping3
echo "[done:] hping3"

