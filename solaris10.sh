#!/bin/bash

virt-install \
--virt-type kvm \
--name=solaris10 \
--os-variant=solaris10 \
--vcpu=1 \
--cpu host-passthrough \
--ram=2048 \
--disk path=~/solaris10.qcow2,size=40,format=qcow2,sparse=true \
--graphics spice \
--video qxl \
--network bridge=br0,model=e1000 \
--metadata title='Solaris 10u11' \
--cdrom ~/sol-10-u11-ga-x86-dvd.iso
