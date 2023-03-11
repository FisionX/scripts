#!/bin/bash
function gpu_end {
    set -x

    # Unload vfio
    rmmod vfio_pci

    # Load modules
    modprobe snd_hda_intel
    modprobe i915

    # Rebind vtconsole
    for i in /sys/class/vtconsole/*/bind; do
        echo 1 > "$i"
    done

    # Start display manager
    systemctl start display-manager.service
}
gpu_end
