#!/bin/sh

LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/); exec >> "$LOGFILE" 2>&1
exec >> "$LOGFILE" 2>&1

# update
echo "[apk-install] todo: update"
apk update
apk upgrade
echo "[apk-install] done: update"

# install git
echo "[apk-install] todo: git"
apk add git
echo "[apk-install] done: git"

# install lynis
echo "[apk-install] todo: lynis"
cd /usr/local/
git clone https://github.com/CISOfy/lynis
cd lynis/
ln -s /usr/local/lynis/lynis /bin/lynis
echo "[apk-install] done: lynis"

# install MACchanger
echo "[apk-install] todo: macchanger"
apk add macchanger
echo "[apk-install] done: macchanger"

# install DNSrecon
echo "[apk-install] todo: dnsrecon"
apk add dnsrecon
echo "[apk-install] done: dnsrecon"

# install nmap
echo "[apk-install] todo: nmap"
apk add nmap
echo "[apk-install] done: nmap"

# install tmux
echo "[apk-install] todo: tmux"
apk add tmux
echo "[apk-install] done: tmux"

# install tshark
echo "[apk-install] todo: tshark"
apk add tshark
echo "[apk-install] done: tshark"

# install hping3
echo "[apk-install] todo: hping3"
apk add hping3
echo "[apk-install] done: hping3"

# install hping3
echo "[apk-install] todo: hping3 (testing)"
apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing hping3
echo "[apk-install] done: hping3 (testing)"

echo "[$0] DONE"
