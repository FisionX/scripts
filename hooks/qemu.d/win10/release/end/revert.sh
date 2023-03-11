#!/bin/bash
set -x

# Re-Bind GPU to Nvidia Driver
virsh nodedev-reattach pci_0000_08_00_1
virsh nodedev-reattach pci_0000_08_00_0

modprobe -r vfio-pci

# Rebind framebuffer to host
echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

modprobe nouveau

# Rebind VT consoles
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind
# Some machines might have more than 1 virtual console. Add a line for each corresponding VTConsole
#echo 1 > /sys/class/vtconsole/vtcon1/bind

#nvidia-xconfig --query-gpu-info > /dev/null 2>&1
