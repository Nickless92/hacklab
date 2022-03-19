#!/bin/bash

clear
sleep 1s
print_paragraph_from_file 1 ./levels/01/story.txt; sleep 1s                      # type 1-3 line with --- and new line at the end
wait_for_any_key                                                # call read asleep function

sleep 1s
echo -ne "\n\n    ---\n\n"
print_loading_arrows .2s; echo -e "greetings.\n"; sleep 1s
print_loading_arrows .2s; echo -e "you may not know who i am but you will soon find out.\n"; sleep 1s
print_loading_arrows .2s; echo -e "expect your current understanding of how the world works to turned on its head.\n"; sleep 1s
print_loading_arrows .2s; echo -e "expect me.\n"; sleep 1s
print_loading_arrows .2s; echo -e "()> 0   <-> 2  <3 10)\n"; sleep 1s
echo -e "\n    ---\n\n"; sleep 1s

print_paragraph_from_file 2 ./levels/01/story.txt sleep 1s
wait_for_any_key

echo -e "\n"
print_loading_arrows .5s; print_paragraph_from_file 3 ./levels/01/story.txt 1s
print_loading_arrows .5s; print_paragraph_from_file 4 ./levels/01/story.txt 1s
print_loading_arrows .5s; print_paragraph_from_file 5 ./levels/01/story.txt 1s
print_loading_arrows .5s; print_paragraph_from_file 6 ./levels/01/story.txt 1s
sleep 1s

print_paragraph_from_file 7 ./levels/01/story.txt 1s
wait_for_any_key

print_paragraph_from_file 8 ./levels/01/story.txt 1s
