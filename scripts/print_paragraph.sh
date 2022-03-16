#!/bin/bash

# tl;dr: retrieve paragraph from file and call print_lines_from_file_then_pause()
# prints a whole paragraph from file ($3), passes on pause time ($2)
# starts at '<ID>', ends at '===' (make sure to put each tag in seperate lines)

# $1: paragraph ID
# $2: pause time    (passed on to print_lines_from_file_then_pause)
# $3: path/to/file  (passed on to print_lines_from_file_then_pause)

file=$(readlink -f "$3")                                                # get path to file
startline=$(( $( grep -n "<$1>" $file | sed s/':.*'/''/ ) + 1 ))        # extract line where <TAG> appears

while read -r match; do                                                 # loop over every match from subproc (line13)
    line=$(echo $match | sed s/':.*'//)                                 # extract line where '===' appeared
    [ $line -gt $startline ] && endline=$(( $line - 1 )); break         # search for first '===' line after <TAG>
done < <(grep -n === $file)                                             # pipe from (subproc) into while loop
                                                                        # subproc: greps for '===' lines in $file

print_lines_from_file_then_pause $startline $endline $2 $3              # FIXME - check if path to script doesn't break