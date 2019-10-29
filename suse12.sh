#!/bin/bash

virt-install \
--virt-type kvm \
--name=suse12 \
--os-variant=sles12sp4 \
--vcpu=1 \
--ram=1024 \
--disk path=~/suse12.qcow2,size=40,format=qcow2,sparse=true,bus=virtio \
--graphics spice \
--video qxl \
--network bridge=br0,model=virtio \
--metadata title='SUSE 12sp4' \
--cdrom ~/SLE-12-SP4-Server-DVD-x86_64-GM-DVD1.iso
