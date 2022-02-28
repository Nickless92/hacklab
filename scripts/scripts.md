# Documentation

## General  
The following scripts describe a uniform way to set up/break down a whole level.

## API  
Calling each process is invoked by pne of two scripts, logging and calling their seperate sub-functions automatically.

### Set up a level  
The general call is `/path/to/script/level_start.sh level devices`  
If the project is cloned right into `$USERHOME` and you want to set up level 1 with 3 devices:  
`~/hacklab/scripts/level_start.sh 1 3`

### Break down a level  
The general call is `/path/to/script/level_stop.sh level devices`  
To break down that same example infrastructur: `~/hacklab/scripts/level_stop.sh 1 3`

## Details  

### Set up
The following scripts are called by level_start (in that order):
| step | script | args  | detail |
| ------ | ------ | ------ | ------ |
| 1. | `./bridge_add` | $1 level | creates a seperate lxc network bridge for each level |
| 2. | `./container_create` | $1 level<br>$2 containers<br>$3 ISO | initializes a level...<br>with a given number of (stopped) containers <br> **optional:** specify ISO by alias/fingerprint |
| 3. | `./container_start` | $1 level<br>$2 containers | starts the specified number of containers (stopped -> running) |
| 4. | `./container_ip_add` | $1 level<br>$2 containers<br>$3 interface | connects each container to the lxc network bridge (L2 links) <br> and sets a level-device-specific IPv4 address (10.10.level.device) <br> **optional:** interface name |

### Break down
The following scripts are called by level_stop (in that order):  
| step | script | args | detail |
| ------ | ------ | ------ | ------ |
| 1. | `./network_ip_del` | $1 level<br>$2 containers<br>$3 interface | disconnects each container of the level<br> from the lxc network bridge<br>**optional:** interface name |
| 2. | `./container_stop` | $1 level<br>$2 containers | sends signal to gracefully stop the containers... |
| 3. | `./container_delete` | $1 level<br>$2 containers | ... before deleting them (instead of --force) |
| 4. | `./bridge_del` | $1 level | deletes the lxc network bridge |
