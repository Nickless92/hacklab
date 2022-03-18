#!/bin/bash

clear
sleep 1s
print_paragraph_from_file 1 ./levels/02/story.txt 1s            # type 1-3 line with --- and new line at the end
wait_for_any_key                                                # call read asleep function

sleep 1s
echo -ne "\n\n    ---\n\n"
loading_arrows .2s; echo -e "greetings.\n"; sleep 1s
loading_arrows .2s; echo -e "You may not know what I'm up to, but you'll soon find out.\n"; sleep 1s
loading_arrows .2s; echo -e "find what's going on here.\n"; sleep 1s
loading_arrows .2s; echo -e "for that you should.\n"; sleep 1s
loading_arrows .2s; echo -e "()> 0   <-> 2  <3 10)\n"; sleep 1s
echo -e "\n    ---\n\n"; sleep 1s
print_paragraph_from_file 2 ./levels/02/story.txt 1s
wait_for_any_key
sleep 1s

echo -e "\n"
loading_arrows .5s; print_paragraph_from_file 3 ./levels/02/story.txt 1s
loading_arrows .5s; print_paragraph_from_file 4 ./levels/02/story.txt 1s
#loading_arrows .5s; print_paragraph_from_file 5 ./levels/02/story.txt 1s
#loading_arrows .5s; print_paragraph_from_file 6 ./levels/02/story.txt 1s
sleep 1s

#print_paragraph_from_file 7 ./levels/02/story.txt 1s
#wait_for_any_key

#print_paragraph_from_file 8 ./levels/02/story.txt 1s

