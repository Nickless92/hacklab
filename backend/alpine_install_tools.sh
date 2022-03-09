#!/bin/sh
# use sh/ash, since there's no bash on alpine linux

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

# update and install several tools for usage with hacklab 

# logging in alpine container
LOGFILE=log ; exec > >(awk '{ print strftime("[%Y-%m-%d %H:%M:%S]"), $0 ; fflush(stdout) }' > "$LOGFILE") 2>&1

# update apk (is this necessary, since alpine/edge should be up-to-date by itself?)
echo "todo: update"
apk update
apk upgrade
echo "done: update"

# install man
echo "todo: man"
apk add mandoc
echo "done: man"

# install git
echo "todo: git"
apk add git
echo "done: git"

# install lynis
echo "todo: lynis"
cd /usr/local/
git clone https://github.com/CISOfy/lynis
cd lynis/
ln -s /usr/local/lynis/lynis /bin/lynis
echo "done: lynis"

# purge git
echo "undo: git"
apk del git
echo "done: git"

# install MACchanger
echo "todo: macchanger"
apk add macchanger
apk add macchanger-doc
echo "done: macchanger"

# install DNSrecon
echo "todo: dnsrecon"
apk add dnsrecon
# didn't find any docu sources in repo
echo "done: dnsrecon"

# install nmap
echo "todo: nmap"
apk add nmap
apk add nmap-doc
echo "done: nmap"

# install tmux
echo "todo: tmux"
apk add tmux
apk add tmux-doc
echo "done: tmux"

# install iptables
echo "todo: iptables"
apk add iptables
apk add iptables-doc
echo "done: iptables"

# install tcpdump
echo "todo: tcpdump"
apk add tcpdump
apk add tcpdump-doc
echo "done: tcpdump"

# install tshark
echo "todo: tshark"
apk add tshark
apk add wireshark-doc
echo "done: tshark"

# try to install hping3 from main repo first
echo "todo: hping3"
apk add hping3
apk add hping3-doc
echo "done: hping3"

# install hping3 from edge/testing repo
echo "todo: hping3 (testing)"
apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing hping3
apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing hping3-doc
echo "done: hping3 (testing)"

# try to install ettercap from main repo first
echo "todo: ettercap"
apk add ettercap
apk add ettercap-doc
echo "done: ettercap"

# install ettercap from edge/testing repo
echo "todo: ettercap (testing)"
apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing ettercap
apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing ettercap-doc
echo "done: ettercap (testing)"

echo "DONE"
