#!/bin/bash

BACKUP_DIR="/backup/vm_images"
DATE=$(date +%Y%m%d)
VM_NAME=$1

virsh dumpxml $VM_NAME > $BACKUP_DIR/$VM_NAME-$DATE.xml
virsh shutdown $VM_NAME
cp /var/lib/libvirt/images/$VM_NAME.qcow2 $BACKUP_DIR/$VM_NAME-$DATE.qcow2
virsh start $VM_NAME

echo "Backup for $VM_NAME completed."

