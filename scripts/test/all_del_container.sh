#!/bin/bash
# deletes all containers from every level 
# regardless of user interaction

level=1
errLevel=0

device=1
errDevice=0

while [ "$errLevel" -eq 0 ]                                     # while return code = 0
do
    _level="$level"
    #if [ $level -lt 10 ]; then _level=0"$level"; fi             # adjusts _level for leading zeros
    while [ "$errDevice" -eq 0 ]                                # while return code = 0
    do
        _device="$device"
        #if [ "$device" -lt 10 ]; then _device=0"$device"; fi    # adjusts _device for leading zeros
        lxc stop lvl"$_level"-d"$_device"                       # stop first and ...
        intErr=lxc delete lvl"$_level"-d"$_device"                     # then delete gracefully
        errDevice="$?"                                          # catch return code

        echo "intErr = $intErr"
        if [ "$errDevice" -eq 0 ]; then echo "[container_remove_all] deleted container lvl$_level-d$_device"; fi
        echo "errDevice = $errDevice"
        echo "device = $device"
        device=$(( $device + 1 ))
    done

    if [ "$device" -eq 1 ] && [ "$level" -gt 5 ]                # tries at least five levels
        then errLevel="$errDevice";                             # if no d01 after lvl05: end
        else errDevice=0; fi                                    # else: reset errDevice
    echo "[container_remove_all] errLevel = $errLevel"
    if [ "$errLevel" -ne 1 ]
        then echo "[container_remove_all] deleted level $_level"
        else echo "[container_remove_all] done"; fi
    device=1
    level=$(( $level + 1 ))
done
