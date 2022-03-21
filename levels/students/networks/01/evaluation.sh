#!/bin/bash

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

# determine if the attack was successful + award points

packets=$(grep -c "10.10.1.3 → 10.10.1.2    ICMP 42 Echo (ping) reply" ausgabe.log) 	#to determine if the correct packets was sent with the correct IP-adress
test=$(grep -c "ICMP 42" ausgabe.log)													#to determine if the correct packets was sent

if [ $packets -eq 7 ]; then
    points=10
	print_colored_ascii ../../../../ressources/ascii/win.txt	
elif [ $packets -ne 7 ] && [ $test -ne 0 ]; then
    points=7
	print_colored_ascii ../../../../ressources/ascii/insufficient.txt
	echo "You haven't send the requested packet number and get 7 points for it!"
    [ $packets -lt 7 ] && echo "You have only sent $packets packets."
    [ $packets -gt 7 ] && echo "You have already sent $packets packets."
else 
    points=0
	print_colored_ascii ../../../../ressources/ascii/lost.txt
    echo "You get 0 points!"
fi
