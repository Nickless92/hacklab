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

#script to determine if the attack (Ip-Spoofing) was successful


#to obtain the file where the User saves his command(filename: command.txt)
#sudo lxc file pull lvl01-c02/root/ausgabe.txt ../levels/01-test/ausgabe.txt

#result=$(diff ../levels/01-test/test.txt command.txt | wc -l)
#file=$(cat command.txt)
#sudo lxc file push ./command.sh test1/root/command.sh


#export lostpoints=0

lxc exec lvl01-c02 -- killall tshark					#kill tshark and the file will be created
sleep 1;												#we need to wait 1 second for moving the file
#mv ausgabe.log ../levels/01-test						#to move the file


paket=$(grep -c "10.10.1.3 → 10.10.1.2    ICMP 42 Echo (ping) reply" ausgabe.log) 	#to determine if the correct pakets was sent with the correct IP-adress
test1=$(grep -c "ICMP 42" ausgabe.log)													#to determine if the correct pakets was sent

#to determine if the user attempt  was successful or not 
if [ "$paket" = "7" ]
then
    points=10
	cat ./ressources/ascii/win.txt	
elif [ "$paket" != 7 ] && [ "$test1" != 0 ]
then 
    cat ./ressources/ascii/insufficient.txt
	 points=6
	echo "You haven't sent the requested paket number! Try Again!"

else 
    points=0
	cat ./ressources/ascii/lost.txt
fi


rm ausgabe.log
#to save all the parameters of the sample solution in variables containing only numbers
#test1=$(grep -c "\-1" command.txt)
#test2=$(grep -c "\-a 10.10.1.2 10.10.1.3" command.txt)
#test3=$(grep -c "\-c 7" command.txt)
#test4=$(grep -c "\-p 80" command.txt)
#test5=$(grep "hping3" command.txt | sed s/" .*"//)


#test to determine if the attack of the user was successful
#to determine if all the parameters of the sample solution are included in the users'command
#if [ "$test1" = 1 ] && [ "$test2" = 1 ] && [ "$test3" = 1 ] && [ "$test4" = 1 ] && [ "$test5" = "hping3" ]
#then 
    # then the user won 
#    cat ../ressources/ascii/win.txt
#else 
    #then the user lost 
#    cat ../ressources/ascii/lost.txt
#fi

