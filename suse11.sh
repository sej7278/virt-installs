#!/bin/bash

virt-install \
--virt-type kvm \
--name=suse11 \
--os-variant=sles11sp4 \
--vcpu=1 \
--ram=1024 \
--disk path=~/suse11.qcow2,size=40,format=qcow2,sparse=true,bus=virtio \
--graphics spice \
--video qxl \
--network bridge=br0,model=virtio \
--metadata title='SUSE 11sp4' \
--cdrom ~/SLES-11-SP4-DVD-x86_64-GM-DVD1.iso
