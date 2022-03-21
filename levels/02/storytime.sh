#!/bin/bash

clear
sleep 1s
print_paragraph_from_file text_1 ./story.txt .5
wait_for_any_key

print_loading_arrows .2s; print_paragraph_from_file tweeb_1 ./story.txt .5
print_loading_arrows .2s; print_paragraph_from_file tweeb_2 ./story.txt .5
print_loading_arrows .2s; print_paragraph_from_file tweeb_3 ./story.txt .5
print_loading_arrows .2s; print_paragraph_from_file tweeb_4 ./story.txt .5
print_loading_arrows .2s; print_paragraph_from_file tweeb_5 ./story.txt .5
wait_for_any_key

print_paragraph_from_file text_2 ./story.txt .5
wait_for_any_key

print_paragraph_from_file text_3 ./story.txt .5
wait_for_any_key
