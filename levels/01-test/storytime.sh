#!/bin/bash

clear
cd $(dirname "$0")
sleep 1s
print_lines_from_file_then_pause 1 3 2 ./story.txt              # type 1-3 line with --- and new line at the end

wait_for_any_key                                                # call read asleep function

sleep 1s
echo -ne "\n\n    ---\n\n"
loading_arrows .5s; echo -e "greetings.\n"
sleep 2s
loading_arrows .5s; echo -e "you may not know who i am but you will soon find out.\n"
sleep 3s
loading_arrows .5s; echo -e "expect your current understanding of how the world works to turned on its head.\n"
sleep 4s
loading_arrows .5s; echo -e "expect me.\n"
sleep 3s
loading_arrows .5s; echo -e "()> 0   <-> 2  <3 10)\n"
sleep 1s
echo -e "\n    ---\n\n"

sleep 2s
print_lines_from_file_then_pause 4 4 2s ./story.txt

sleep 1s 
print_lines_from_file_then_pause 5 6 2s ./story.txt

wait_for_any_key

sleep 1s ; echo " "
print_lines_from_file_then_pause 7 10 1s ./story.txt 

sleep 1s
print_lines_from_file_then_pause 11 13 2s ./story.txt

wait_for_any_key

print_lines_from_file_then_pause 14 19 4s ./story.txt
cd -