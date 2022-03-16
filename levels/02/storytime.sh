#!/bin/bash

clear
sleep 1s
print_lines_from_file_then_pause 1 3 1 story.txt                # type 1-3 line with --- and new line at the end

wait_for_any_key                                                # call read asleep function

sleep 1s
echo -ne "\n\n    ---\n\n"
loading_arrows .2s; echo -e "greetings.\n"
sleep 1s
loading_arrows .2s; echo -e "You may not know what I'm up to, but you'll soon find out.\n"
sleep 1s
loading_arrows .2s; echo -e "find what's going on here.\n"
sleep 1s
loading_arrows .2s; echo -e "for that you should.\n"
sleep 1s
loading_arrows .2s; echo -e "()> 0   <-> 2  <3 10)\n"
sleep 1s
echo -e "\n    ---\n\n"

sleep 1s
print_lines_from_file_then_pause 4 4 1s ./story.txt

sleep 1s
print_lines_from_file_then_pause 5 5 1s ./story.txt

wait_for_any_key

#loading_arrows .5s; print_lines_from_file_then_pause 8 8 1s ./story.txt
#loading_arrows .5s; print_lines_from_file_then_pause 9 9 1s ./story.txt
#loading_arrows .5s; print_lines_from_file_then_pause 10 10 1s ./story.txt 

#sleep 1s
#print_lines_from_file_then_pause 11 13 2s ./story.txt

#wait_for_any_key

#print_lines_from_file_then_pause 14 19 4s ./story.txt
