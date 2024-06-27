#!/bin/bash

VM_NAME=$1
VM_PATH="/var/lib/libvirt/images/${VM_NAME}.qcow2"
ISO_PATH="/path/to/installation.iso"

qemu-img create -f qcow2 $VM_PATH 20G
virt-install --name $VM_NAME --ram 2048 --vcpus 2 \
             --disk path=$VM_PATH,format=qcow2 \
             --cdrom $ISO_PATH --os-type linux --os-variant ubuntu20.04 \
             --network network=default

echo "Virtual Machine $VM_NAME created and started."

