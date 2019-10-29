#!/bin/bash

virt-install \
--virt-type kvm \
--name solaris11 \
--os-variant solaris11 \
--vcpus 2 \
--cpu host-passthrough,disable=x2apic \
--ram 4096 \
--disk path=~/solaris11.qcow2,size=40,format=qcow2,sparse=true,bus=sata \
--graphics spice \
--video qxl \
--network bridge=br0,model=e1000 \
--metadata title='Solaris 11.4' \
--cdrom ~/sol-11_4-text-x86.iso

<<COMMENTS

disabling x2apic reduces the cpu usage from 100%

COMMENTS
