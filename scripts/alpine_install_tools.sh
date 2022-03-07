#!/bin/sh
# no bash available, hence /bin/sh

# SPDX-FileCopyrightText: 2022 Bassam-Khaled Thiab <inf3891@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Dominic Meyer <inf3644@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Felix Rheinheimer <felix.rheinheimer@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Jean-Arole Fotsing <inf3608@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Katrin Vollhardt <inf3493@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Steve Landry Tchamabe <infXXXX@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Syed Saad-Ullah <inf3664@hs-worms.de>
# SPDX-FileCopyrightText: 2022 Thierry-Junior Djeutchou-Njieyong <inf3494@hs-worms.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# script to update and install several tools for usage with hacklab 

# logging in container
LOGFILE=$(echo "$0" | sed s/'.sh'/'.log'/) ; exec > "$LOGFILE" 2>&1

# update
echo "[$(date)] todo: update"
apk update
apk upgrade
echo "[$(date)] done: update"

# install man
echo "[$(date)] todo: man"
apk add mandoc
echo "[$(date)] done: man"

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
apk add macchanger-doc
echo "[$(date)] done: macchanger"

# install DNSrecon
echo "[$(date)] todo: dnsrecon"
apk add dnsrecon
# didn't find any docu sources in repo
echo "[$(date)] done: dnsrecon"

# install nmap
echo "[$(date)] todo: nmap"
apk add nmap
apk add nmap-doc
echo "[$(date)] done: nmap"

# install tmux
echo "[$(date)] todo: tmux"
apk add tmux
apk add tmux-doc
echo "[$(date)] done: tmux"

# install iptables
echo "[$(date)] todo: iptables"
apk add iptables
apk add iptables-doc
echo "[$(date)] done: iptables"

# install tshark
echo "[$(date)] todo: tshark"
apk add tshark
apk add wireshark-doc
echo "[$(date)] done: tshark"

# try to install hping3 from main repo first
echo "[$(date)] todo: hping3"
apk add hping3
apk add hping3-doc
echo "[$(date)] done: hping3"

# install hping3 from edge/testing repo
echo "[$(date)] todo: hping3 (testing)"
apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing hping3
apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing hping3-doc
echo "[$(date)] done: hping3 (testing)"

# try to install ettercap from main repo first
echo "[$(date)] todo: ettercap"
apk add ettercap
apk add ettercap-doc
echo "[$(date)] done: ettercap"

# install ettercap from edge/testing repo
echo "[$(date)] todo: ettercap (testing)"
apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing ettercap
apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing ettercap-doc
echo "[$(date)] done: ettercap (testing)"

echo "[$(date)] DONE"
