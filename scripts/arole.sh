#!/bin/bash

echo -e "\n\n[*** commands to create a bridge and attach containers to it ***]"
cat /home/test/create_bridge.docu

echo -e "\n\n[*** ansible scripts to create container ***]"
cat /home/test/ansible/create_container/tasks/main.yml

echo -e "\n\n[*** ansible script to create bridge ***]"
cat /home/test/ansible/create_bridge/tasks/main.yml

echo -e "\n"
