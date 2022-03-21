#!/bin/bash

clear
sleep 1s
print_paragraph_from_file text_1 ./levels/01/story.txt 1s
wait_for_any_key

print_loading_arrows; print_paragraph_from_file tweeb_1 ./levels/01/story.txt .5
print_loading_arrows; print_paragraph_from_file tweeb_2 ./levels/01/story.txt .5
print_loading_arrows; print_paragraph_from_file tweeb_3 ./levels/01/story.txt .5
print_loading_arrows; print_paragraph_from_file tweeb_4 ./levels/01/story.txt .5
print_loading_arrows; print_paragraph_from_file tweeb_5 ./levels/01/story.txt .5
sleep 1s

print_paragraph_from_file text_2 ./levels/01/story.txt 1s
wait_for_any_key

print_loading_arrows; print_paragraph_from_file tweeb_6 ./levels/01/story.txt .5
print_loading_arrows; print_paragraph_from_file tweeb_7 ./levels/01/story.txt .5
print_loading_arrows; print_paragraph_from_file tweeb_8 ./levels/01/story.txt .5
print_loading_arrows; print_paragraph_from_file tweeb_9 ./levels/01/story.txt .5
sleep 1s

print_paragraph_from_file text_3 ./levels/01/story.txt 1s
wait_for_any_key

print_paragraph_from_file text_4 ./levels/01/story.txt 1s
wait_for_any_key
