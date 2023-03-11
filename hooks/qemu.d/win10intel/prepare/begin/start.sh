#!/bin/bash
function gpu_begin {
    set -x

    device=$(lspci -nnD | grep "VGA compatible controller" | grep Intel)

    # Stop display manager
    killall -u fernando

    # Unbind vtconsole
    for i in /sys/class/vtconsole/*/bind; do
        echo 0 > "$i"
    done

    # Unbind GPU
    echo "$device" | cut -d' ' -f1 > /sys/module/i915/drivers/pci:i915/unbind

    # Unload modules
    rmmod snd_hda_intel
    rmmod i915

    # Load vfio
    modprobe vfio-pci ids="$(echo "$device" | grep -o 8086:....)"
}
gpu_begin
