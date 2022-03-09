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

# determine if the attack (ip spoofing) was successful

# to obtain the file where the User saves his command(filename: command.txt)
lxc file pull lvl01-c01/root/command.txt ../levels/01-test/command.txt

#result=$(diff ../levels/01-test/test.txt command.txt | wc -l)
#file=$(cat command.txt)
#lxc file push ./command.sh test1/root/command.sh

# to save all the parameters of the sample solution in variables containing only numbers
test1=$(grep -c "\-1" ../levels/01-test/command.txt)
test2=$(grep -c "\-a 10.10.1.2 10.10.1.3" ../levels/01-test/command.txt)
test3=$(grep -c "\-c 7" ../levels/01-test/command.txt)
test4=$(grep -c "\-p 80" ../levels/01-test/command.txt)
test5=$(grep "hping3" ../levels/01-test/command.txt | sed s/" .*"//)

# test to determine if the attack of the user was successful
# to determine if all the parameters of the sample solution are included in the users'command
if [ "$test1" = 1 ] && [ "$test2" = 1 ] && [ "$test3" = 1 ] && [ "$test4" = 1 ] && [ "$test5" = "hping3" ]
then 
    # then the user won 
    cat ../ressources/ascii/win.txt
else 
    #then the user lost 
    cat ../ressources/ascii/lost.txt
fi
