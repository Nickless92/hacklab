#!/bin/bash

clear
sleep 1s
print_lines_from_file_then_pause 1 3 1 story.txt                # type 1-3 line with --- and new line at the end

wait_for_any_key                                                # call read asleep function

sleep 1s
echo -ne "\n\n    ---\n\n"
loading_arrows .2s; echo -e "greetings.\n"
sleep 1s
loading_arrows .2s; echo -e "you may not know who i am but you will soon find out.\n"
sleep 1s
loading_arrows .2s; echo -e "expect your current understanding of how the world works to turned on its head.\n"
sleep 1s
loading_arrows .2s; echo -e "expect me.\n"
sleep 1s
loading_arrows .2s; echo -e "()> 0   <-> 2  <3 10)\n"
sleep 1s
echo -e "\n    ---\n\n"

sleep 1s
print_lines_from_file_then_pause 4 4 1s ./story.txt

sleep 1s 
print_lines_from_file_then_pause 5 6 1s ./story.txt

wait_for_any_key

echo -e "\n"
loading_arrows .5s; print_lines_from_file_then_pause 7 7 1s ./story.txt
loading_arrows .5s; print_lines_from_file_then_pause 8 8 1s ./story.txt
loading_arrows .5s; print_lines_from_file_then_pause 9 9 1s ./story.txt
loading_arrows .5s; print_lines_from_file_then_pause 10 10 1s ./story.txt 

sleep 1s
print_lines_from_file_then_pause 11 13 1s ./story.txt

wait_for_any_key

print_lines_from_file_then_pause 14 19 1s ./story.txt

print_lines_from_file_then_pause 20 21 1s ./story.txt
