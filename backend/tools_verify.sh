#!/bin/bash

set -e

function cd_return {
    cd - > /dev/null                                    # cd to former working dir
}

function verify {
    if [ "$#" -eq 1 ]; then
        type $1 || (echo "Error: $1 is required, but not installed. Aborting."; exit 1)
    elif [ "$#" -eq 2 ]; then
        #[ $1 = $(type -t $2) ] 2> /dev/null && echo "check: $2 = $1" || \
        #(echo "Error: $2 is not of type $1."; exit 1)
        [ $1 = $(type -t $2) ] 2> /dev/null || \
        (echo "Error: $2 is required, but not of type $1. Aborting."; exit 1)
    elif [ "$#" -eq 3 ]; then
        verify $1 $2
        [ $($2 -V) = $3 ] || [ $($2 --version) = $3 ] || \
        (echo "Warning: $2's verion is not $3.")
    else echo "Warning: invalid number of parameters (max 2 expected, $# given): $@"; fi
}

trap cd_return EXIT                                     # trap 'exit', run cd_return first
cd $(dirname "$0") ; . log_with_timestamp.sh            # cd to path/to/$0, write to ./logs/
verify file tmux "tmux 3.0a" || verify file tmux "tmux next-3.4"
verify file lxd
verify file lxc
verify file gpg
verify file awk
verify file gawk
verify file mail
# verify tmux/tshark version

#verify alias hacklab