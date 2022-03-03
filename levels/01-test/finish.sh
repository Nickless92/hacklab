#!/bin/bash

#script to determine if the attack (Ip-Spoofing) was successful

#to control the logs from the victim in tshark
#sudo lxc exec test2 -- tshark -c 7 > log.txt

#sudo lxc exec lvl01-d01 -- cat ./.ash_history | tail -n2 > command.txt | head -n1
sudo lxc file pull lvl01-d01/root/command.txt ./command.txt

result=$(diff ../levels/01-test/test.txt command.txt | wc -l)
#command to do the attack
#file=$(cat command.txt)
#sudo lxc file push ./command.sh test1/root/command.sh
#sudo lxc exec test1 -- sh command.sh
#sudo lxc exec test2 -- tshark -c 7 > log.txt
#sudo lxc exec test1 -- sh command.sh

#lxc exec VM1 -- ping -c5 8.8.8.8 > log.txt


#to determine how many request and reply receive the victim
#reply=$(grep reply log.txt | wc -l)
#request=$(grep request log.txt | wc -l)
#variable=$(cat command.txt)
#echo "$variable"

test1=$(grep -c "\-1" command.txt)
test2=$(grep -c "\-a 10.10.1.2 10.10.1.3" command.txt)
test3=$(grep -c "\-c 7" command.txt)
test4=$(grep -c "\-p 80" command.txt)
test5=$(grep "hping3" command.txt | sed s/" .*"//)

#test to determine if the attack of the user was successful
if [ "$test1" = 1 ] && [ "$test2" = 1 ] && [ "$test3" = 1 ] && [ "$test4" = 1 ] && [ "$test5" = "hping3" ]
then 
cat ../ressources/ascii/win.txt
fi

#to know if the user was successful
if [ "$result" = 0 ]
then 
echo The attack was successful
fi
