#!/bin/bash

#path=$("$0" | sed s\#'api.sh'\#''\#)
cd ../scripts/
./$1 $2 $3 $4
cd -