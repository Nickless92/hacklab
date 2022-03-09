#!/bin/bash

#script to determine if the attack (Ip-Spoofing) was successful


#to obtain the file where the User saves his command(filename: command.txt)
#sudo lxc file pull lvl01-d01/root/command.txt ./command.txt
sudo lxc file pull lvl02-c03/root/ausgabe_opfe.txt ./ausgabe_opfer.txt
sudo lxc file pull lvl02-c01/root/ausgabe_angreife.txt ./ausgabe_angreifer.txt

#result=$(diff ../levels/01-test/test.txt command.txt | wc -l)
#file=$(cat command.txt)
#sudo lxc file push ./command.sh test1/root/command.sh



#to save all the parameters of the sample solution in variables containing only numbers

test1=$(sudo tcpdump -r ausgabe_opfer.txt | grep -c "ARP, Request who-has 10.10.2.3 tell 10.10.2.1")
#test2=$(sudo tcpdump -r ausgabe_opfer.txt | grep -c "ARP, Reply 10.10.2.3 is-at 00:16:3e:4b:a0:bd")
test3=$(sudo tcpdump -r ausgabe_opfer.txt | grep -c "ARP, Request who-has 10.10.2.2 tell 10.10.2.1")
test4=$(sudo tcpdump -r ausgabe_opfer.txt | grep -c "ARP, Reply 10.10.2.2 is-at 00:16:3e:4b:a0:bd")

# save hacker packet

test5=$(sudo tcpdump -r ausgabe_angreifer.txt | grep -c "IP 10.10.2.2 > 10.10.2.3:")
test6=$(sudo tcpdump -r ausgabe_angreifer.txt | grep -c "IP 10.10.2.3 > 10.10.2.2:")
test7=$(sudo tcpdump -r ausgabe_angreifer.txt | grep -c "ARP, Reply 10.10.2.2 is-at 00:16:3e:4b:a0:bd")
test9=$(sudo tcpdump -r ausgabe_angreifer.txt | grep -c "Request who-has 10.10.2.3 tell 10.10.2.")
test8=$(sudo tcpdump -r ausgabe_angreifer.txt | grep -c "ARP, Reply 10.10.2.3 is-at 00:16:3e:4b:a0:bd")
#test to determine if the attack of the user was successful
#to determine if all the parameters of the sample solution are included in the users'command
clear
if [ "$test1" > 0 ] && [ "$test3" > 0 ] && [ "$test4" > 0 ] && [ "$test5" > 0 ]&& [ "$test5" > 0 ] && [ "$test6" > 0 ] && [ "$test7" > 0 ] && [ "$test8" > 0 ] && [ "$test9" > 0 ]
then 
    # then the user won 
cat ../ressources/ascii/win.txt
else 
    #then the user lost
cat ../ressources/ascii/lost.txt
fi

unlink ausgabe_opfer.txt
unlink ausgabe_angreifer.txt
sudo lxc exec lvl02-c03 -- rm ausgabe_opfe.txt
sudo lxc exec lvl02-c03 -- rm ausgabe_angreife.txt
clear
