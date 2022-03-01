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
|----------------|----------------|
| general call   | `/path/to/script/level_start.sh level devices` |
| level 1 with 3 devices<br> scripts in `$USERHOME` | `~/hacklab/scripts/level_start.sh 1 3` |

| Break down a level | level_stop.sh |
|--------------------|---------------|
| general call       | `/path/to/script/level_stop.sh level devices` |
| level 1 with 3 devices<br> scripts in `$USERHOME` | `~/hacklab/scripts/level_stop.sh 1 3`  |


### Details

<details>
<summary>level_start.sh</summary>
The following scripts are called by level_start (in that order):

| step | script | args  | detail |
|------|--------|-------|--------|
| 0.   | number of parameters   | 2 <br> _3 (tbd)_ <br> _4 (tbd)_ | level, number of devices <br> _level, number of devices, ISO_ <br> _level, number of devices, ISO, interface_ |
| 1.   | `./bridge_add.sh`       | $1 level | creates a seperate lxc network bridge for each level |
| 2.   | `./container_create.sh` | $1 level<br>$2 containers<br>_$3 ISO_ | initializes a level... (state: stopped) <br> with a given number of containers <br> _optional: ISO alias - default: alpine-iso-utils_ |
| 3.   | `./container_start.sh`  | $1 level<br>$2 containers | starts a level... (stopped -> running) <br> with the specified number of containers |
| 4.   | `./container_ip_add.sh` | $1 level<br>$2 containers<br>_$3 interface_ | connects each container to lxc network bridge (L2 links) <br> and sets a level-device-specific IPv4 address (10.10.level.device) <br> _optional: interface name - default: eth0_ |
</details>

<details>
<summary>level_stop.sh</summary>
The following scripts are called by level_stop (in that order):  

| step | script | args | detail |
|------|--------|------|--------|
| 0.   | number of parameters   | 2 <br> _3 (tbd)_ <br> _4 (tbd)_ | level, number of devices <br> _level, number of devices, ISO_ <br> _level, number of devices, ISO, interface_ |
| 1.   | `./network_ip_del.sh`  | $1 level<br>$2 containers<br>_$3 interface_ | disconnects each container of the level... <br> ...from the lxc network bridge<br>_optional: interface name - default: eth0_ |
| 2.   | `./container_stop.sh`  | $1 level<br>$2 containers | stops a level... (running -> stopped) <br> ... with a specified number of containers |
| 3.   | `./container_delete.sh`| $1 level<br>$2 containers | deletes a level... (state: stopped, without --force) <br> ... with a specified number of containers |
| 4.   | `./bridge_del.sh`      | $1 level                  | deletes the lxc network bridge |
</details>

<details>
<summary>bridge_add.sh</summary>

| step | command | args | detail |
|------|---------|------|--------|
| 0.   | number of parameters    | 1        | takes in one arg as `XY` in `lvlbrXY` <br> else: breaks |
| 1.   | `brctl addbr $1 up`     | $1 level | adds and starts a bridge named $1 |
| 2.   | `ip link set dev $1 up` | $1 level | adds and starts the L2 link |
</details>

<details>
<summary>bridge_del.sh</summary>

| step | command | args | detail |
|------|---------|------|--------|
| 0. | number of parameters      | 1        | takes in one arg as `XY` in `lvlbrXY` <br> else: breaks |
| 1. | `ip link set dev $1 down` | $1 level | stops and deletes the L2 link |
| 2. | `brctl delbr $1`          | $1 level | stops and deletes the bridge |
</details>

<details>
<summary>container_create.sh</summary>

| step | command | args | detail |
|------|---------|------|--------|
| 0. | number of parameters | 2 <br> 3 | level, containers <br> level, devices, ISO alias |
| 1. | `lxc init ISO level-device` | $1 level <br> $2 containers <br> _$3 ISO_ | initializes a level... (state: stopped) <br> ... with a given number of containers <br> _optional: ISO alias/fingerprint - default: alpine-iso-utils_  |
| 2. | `lxc init ISO level-target` <br> **tbd: not yet implemented** | $1 level <br> $2 == "target" <br> $3 ISO | creates a _target container_ for $level... <br> ... to provide a target with specific vulnerabilities <br> ISO: non-optional, must be specified  |
</details>

<details>
<summary>container_start.sh</summary>

| step | command | args | detail |
|------|---------|------|--------|
| 0. | number of parameters | 2 | level, containers |
| 1. | `lxc start level-device` | $1 level <br> $2 containers | starts a level... (stopped -> running) <br> ... with the specified number of containers |
| 2. | `lxc start level-target` | $1 level | always try to start a target container |
</details>

<details>
<summary>container_stop.sh</summary>

| step | command | args | detail |
|------|---------|------|--------|
| 0. | number of parameters | 2 | level, containers |
| 1. | `lxc stop level-device` | $1 level <br> $2 containers | stops a level... (running -> stopped) <br> ... with a specified number of containers |
| 2. | `lxc stop level-target` | $1 level | always try to stop a target container |
</details>

<details>
<summary>container_delete.sh</summary>

| step | command | args | detail |
|------|---------|------|--------|
| 0. | number of parameters | 2 | level, containers |
| 1. | `lxc delete level-device` | $1 level <br> $2 containers | deletes a level... (only when stopped) <br> ... with a specified number of containers |
| 2. | `lxc delete level-target` | $1 level | always try to delete a target container |
</details>

<details>
<summary>container_ip_add.sh</summary>

| step | command | args | detail |
|------|---------|------|--------|
| 0. | number of parameters | 2 <br> 3 | level, containers <br> level, devices, interface |
| 1. | `lxc config device add level-device interface` <br> `nic nictype=bridged parent=level name=interface` | $1 level <br> $2 containers <br> _$3 interface_ | changes config of container "level-device"... <br> ... to add network interface "eth0" <br> _optional: interface, if different from eth0_ |
| 2. | `lxc exec level-device --` <br> `ip addr add 10.10.level.device/24 dev interface` | $1 level <br> $2 containers <br> _$3 interface_ | sudo into container "level-device"... <br> ... to add IP to "interface" <br> _optional: interface, if different from eth0_ |
| 3. | `lxc exec level-device --` <br> `ip link set dev interface up` | $1 level <br> $2 containers <br> _$3 interface_| sudo into container "level-device"... <br> ... to start L2 link of "eth0" <br> _optional: interface, if different from eth0_ |
</details>

<details>
<summary>container_ip_del.sh</summary>

| step | command | args | detail |
|------|---------|------|--------|
| 0. | number of parameters | 2 <br> 3 | level, containers <br> level, devices, interface |
| 1. | `lxc exec level-device --` <br> `ip link set dev interface down` | $1 level <br> $2 containers <br> _$3 interface_ | sudo into container "level-device"... <br> ... to stop L2 link of "eth0" <br> _optional: interface, if different from eth0_ |
| 2. | `lxc exec level-device --` <br> `ip addr del 10.10.level.device/24 dev interface` | $1 level <br> $2 containers <br> _$3 interface_ | sudo into container "level-device"... <br> ... to delete IP from "interface" <br> _optional: interface, if different from eth0_ |
| 3. | `lxc config device remove level-device interface` | $1 level <br> $2 containers <br> _$3 interface_ | changes config of container "level-device"... <br> ... to delete network interface "eth0" <br> _optional: interface, if different from eth0_ |
</details>
