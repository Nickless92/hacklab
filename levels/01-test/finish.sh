#!/bin/bash

#script to determine if the attack (Ip-Spoofing) was successful


#to obtain the file where the User saves his command(filename: command.txt)
sudo lxc file pull lvl01-d01/root/command.txt ./command.txt

#result=$(diff ../levels/01-test/test.txt command.txt | wc -l)
#file=$(cat command.txt)
#sudo lxc file push ./command.sh test1/root/command.sh



#to save all the parameters of the sample solution in variables containing only numbers
test1=$(grep -c "\-1" command.txt)
test2=$(grep -c "\-a 10.10.1.2 10.10.1.3" command.txt)
test3=$(grep -c "\-c 7" command.txt)
test4=$(grep -c "\-p 80" command.txt)
test5=$(grep "hping3" command.txt | sed s/" .*"//)


#test to determine if the attack of the user was successful
#to determine if all the parameters of the sample solution are included in the users'command
if [ "$test1" = 1 ] && [ "$test2" = 1 ] && [ "$test3" = 1 ] && [ "$test4" = 1 ] && [ "$test5" = "hping3" ]
then 
    # then the user won 
    cat ../ressources/ascii/win.txt
else 
    #then the user lost 
    cat ../ressources/ascii/lost.txt
fi

