#!/bin/bash

for VM in $(virsh list --name); do
    STATUS=$(virsh domstate $VM)
    if [ "$STATUS" != "running" ]; then
        echo "VM $VM is not running. Attempting to start."
        virsh start $VM
    else
        echo "VM $VM is running."
    fi
done

