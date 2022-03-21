#!/bin/bash

# determine if the attack (ARP-Poisoning) was successful

lxc file pull lvl02-c03/root/opfer.txt ./levels/02/ausgabe_opfer.txt                                           # to pull the file with packets
lxc file pull lvl02-c01/root/angreifer.txt ./levels/02/ausgabe_angreifer.txt

# to save all the parameters of the sample solution in variables containing only numbers
test1=$(sudo tcpdump -r ./levels/02/ausgabe_opfer.txt | grep -c "ARP, Request who-has 10.10.2.3 tell 10.10.2.1")    # ARP Broatcast for 10.10.2.3
test2=$(sudo tcpdump -r ./levels/02/ausgabe_opfer.txt | grep -c "ARP, Request who-has 10.10.2.2 tell 10.10.2.1")    # ARP Broatcast for 10.10.2.2
test3=$(sudo tcpdump -r ./levels/02/ausgabe_opfer.txt | grep -c "ARP, Reply 10.10.2.2 is-at 00:00:00:00:00:11")     # ARP-Reply from attacker(00:00:00:00:00:00)
test4=$(sudo tcpdump -r ./levels/02/ausgabe_opfer.txt | grep -c "IP 10.10.2.2 > 10.10.2.3:")                        # Packet from 10.10.2.2

# save hacker packet
test5=$(sudo tcpdump -r ./levels/02/ausgabe_angreifer.txt | grep -c "IP 10.10.2.2 > 10.10.2.3:")                    # hacker can see the Packet from 10.10.2.2 to 10.10.2.3
test6=$(sudo tcpdump -r ./levels/02/ausgabe_angreifer.txt | grep -c "IP 10.10.2.3 > 10.10.2.2:")                    # hacker can see the Packet from 10.10.2.3 to 10.10.2.2
test7=$(sudo tcpdump -r ./levels/02/ausgabe_angreifer.txt | grep -c "ARP, Reply 10.10.2.2 is-at 00:00:00:00:00:11") # hacker ARP-Reply that he is 10.10.2.2
test8=$(sudo tcpdump -r ./levels/02/ausgabe_angreifer.txt | grep -c "ARP, Reply 10.10.2.3 is-at 00:00:00:00:00:11") # hacker ARP-Reply that he is 10.10.2.3

# determine if all parameters of the sample solution are included
if [[ "$test1" > 0 ]] && [[ "$test2" > 0 ]] && [[ "$test3" > 0 ]] && [[ "$test4" > 0 ]] && [[ "$test5" > 0 ]] && [[ "$test5" > 0 ]] && [[ "$test6" > 0 ]] && [[ "$test7" > 0 ]] && [[ "$test8" > 0 ]]
then 
    points=10
    print_colored_ascii ../../ressources/ascii/win.txt
else
	points=0
    print_colored_ascii ../../ressources/ascii/lost.txt
fi

rm ./levels/02/ausgabe_opfer.txt 2> /dev/null                                                                       # delete local file
rm ./levels/02/ausgabe_angreifer.txt 2> /dev/null                                                                   # delete local file

lxc exec lvl02-c03 -- rm opfer.txt 2> /dev/null                                                                     # delete file in lvl02-c03 (10.10.2.3)
lxc exec lvl02-c01 -- rm angreifer.txt 2> /dev/null                                                                 # delete file in lvl02-c01 (10.10.2.1)
