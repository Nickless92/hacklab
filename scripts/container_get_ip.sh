#!/bin/sh

<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
# script to get a container's own IP

>>>>>>> Stashed changes
ip a | grep "global eth0" | sed 's/    inet //' | sed 's/\/.*//' > my_ip.txt
>>>>>>> Stashed changes

# script to get a container's own IP

ip a | grep "global eth0" | sed 's/    inet //' | sed 's/\/.*//' > my_ip.txt
