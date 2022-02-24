#!/bin/bash
# script to remove log files

rm -f *.log
rm -ri ./logs/
rm -ri /var/log/hacklab/
echo "All log files deleted! =)"
