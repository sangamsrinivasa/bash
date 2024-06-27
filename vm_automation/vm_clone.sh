#!/bin/bash

SRC_VM=$1
DST_VM=$2
SNAPSHOT_NAME="${SRC_VM}_snapshot"

virsh snapshot-create-as $SRC_VM $SNAPSHOT_NAME --atomic
virsh dumpxml $SRC_VM > /tmp/$SRC_VM.xml
sed -i "s/$SRC_VM/$DST_VM/g" /tmp/$SRC_VM.xml
virsh define /tmp/$SRC_VM.xml
virsh start $DST_VM

