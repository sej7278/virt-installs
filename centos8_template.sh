#!/bin/bash

virt-install \
--virt-type kvm \
--name=centos8 \
--os-variant=centos8 \
--cpu host-passthrough \
--vcpus 4 \
--memory 4096 \
--disk path=~/centos8.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--video none \
--metadata title="CentOS 8.3" \
--location ~/CentOS-8.3.2011-x86_64-dvd1.iso \
--extra-args='console=tty0 console=ttyS0,115200n8 serial'

<<COMMENTS

systemctl enable fstrim.timer
systemctl start fstrim.timer

COMMENTS
