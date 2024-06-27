#!/bin/bash

for VM in $(virsh list --name); do
    CPU=$(virsh domstats $VM --vcpu | grep vcpu.time | awk '{print $2}')
    MEMORY=$(virsh domstats $VM --memory | grep balloon.current | awk '{print $2}')
    echo "VM: $VM - CPU: $CPU - Memory: $MEMORY"
done

