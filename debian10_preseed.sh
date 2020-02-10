#!/bin/bash

virt-install \
--virt-type kvm \
--name busterps  \
--os-variant debian10 \
--vcpus 1 \
--cpu host-passthrough \
--ram 2048 \
--disk path=~/busterps.qcow2,size=20,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--graphics none \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--metadata title='Debian Buster (Preseed)' \
--metadata description='192.168.1.1' \
--location ~/debian-10.3.0-amd64-DVD-1.iso \
--initrd-inject=preseed.cfg \
--extra-args='console=tty0 console=ttyS0,115200n8 serial' \
--noreboot


<<COMMENTS

https://www.debian.org/releases/buster/example-preseed.txt
https://wiki.debian.org/DebianInstaller/Preseed

COMMENTS
