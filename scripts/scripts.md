# Documentation  

## Bash Scripts  

### General  
The following scripts describe a uniform way to set up/break down a whole level.

### API  
Calling each process is invoked by one of two scripts.  
These automatically care for logging and calling their seperate sub-functions.  

General rule of thumb: call a script by its relative path.  
Provide parameters as digits, divided by blanks, but withouth leading zeros.  

| Set up a level | level_start.sh |
|---|---|
| general call | `/path/to/script/level_start.sh level devices` |
| level 1 with 3 devices<br> scripts in `$USERHOME` | `~/hacklab/scripts/level_start.sh 1 3` |

| Break down a level | level_stop.sh |
|---|---|
| general call | `/path/to/script/level_stop.sh level devices` |
| level 1 with 3 devices<br> scripts in `$USERHOME` | `~/hacklab/scripts/level_stop.sh 1 3`  |


### Details

<details>
<summary>level_start.sh</summary>
The following scripts are called by level_start (in that order):

| step | script | args  | detail |
| ------ | ------ | ------ | ------ |
| 1. | `./bridge_add.sh` | $1 level | creates a seperate lxc network bridge for each level |
| 2. | `./container_create.sh` | $1 level<br>$2 containers<br>_$3 ISO_ | initializes a level...<br>with a given number of (stopped) containers <br> _**optional**: specify ISO (alias/fingerprint) - **default**: alpine-iso-utils_ |
| 3. | `./container_start.sh` | $1 level<br>$2 containers | starts the specified number of containers (stopped -> running) |
| 4. | `./container_ip_add.sh` | $1 level<br>$2 containers<br>_$3 interface_ | connects each container to the lxc network bridge (L2 links) <br> and sets a level-device-specific IPv4 address (10.10.level.device) <br> _optional: interface name_ |
</details>

<details>
<summary>level_stop.sh</summary>
The following scripts are called by level_stop (in that order):  

| step | script | args | detail |
| ------ | ------ | ------ | ------ |
| 1. | `./network_ip_del.sh` | $1 level<br>$2 containers<br>$3 interface | disconnects each container of the level<br> from the lxc network bridge<br>_**optional**: interface name - **default:** eno1_ |
| 2. | `./container_stop.sh` | $1 level<br>$2 containers | sends signal to gracefully stop the containers... |
| 3. | `./container_delete.sh` | $1 level<br>$2 containers | ... before deleting them (instead of --force) |
| 4. | `./bridge_del.sh` | $1 level | deletes the lxc network bridge |
</details>

<details>
<summary>bridge_add.sh</summary>
test
</details>

<details>
<summary>bridge_del.sh</summary>
test
</details>

<details>
<summary>container_create.sh</summary>
test
</details>

<details>
<summary>container_start.sh</summary>
test
</details>

<details>
<summary>container_stop.sh</summary>
test
</details>

<details>
<summary>container_delete.sh</summary>
test
</details>

<details>
<summary>container_ip_add.sh</summary>
test
</details>

<details>
<summary>container_ip_del.sh</summary>
test
</details>
