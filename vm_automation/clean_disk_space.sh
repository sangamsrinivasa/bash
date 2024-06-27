#!/bin/bash

VM_NAME=$1
THRESHOLD=80

USAGE=$(df -h /var/lib/libvirt/images | grep -v Filesystem | awk '{print $5}' | sed 's/%//')

if [ $USAGE -gt $THRESHOLD ]; then
    echo "Disk usage is above $THRESHOLD%. Cleaning up old snapshots and logs."
    find /var/lib/libvirt/images -type f -name "*.old" -exec rm -f {} \;
    find /var/log/libvirt -type f -name "*.log" -mtime +30 -exec rm -f {} \;
    echo "Cleanup completed."
else
    echo "Disk usage is below $THRESHOLD%. No cleanup needed."
fi

