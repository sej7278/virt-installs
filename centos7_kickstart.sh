#!/bin/bash

VMNAME="kickstart"

virt-install \
--virt-type kvm \
--name=centos7_${VMNAME} \
--os-variant=rhel7.6 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=~/centos7_${VMNAME}.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="CentOS 7.7 (${VMNAME})" \
--location ~/CentOS-7.7-x86_64-Everything-1908.iso \
--extra-args='ks=file:centos7_kickstart.cfg' \
--initrd-inject=centos7_kickstart.cfg \
--noreboot


<<COMMENTS

kickstart and virt-install should take care of this for you:

systemctl enable fstrim.timer
systemctl start fstrim.timer

systemctl enable serial-getty@ttyS0.service
systemctl start serial-getty@ttyS0.service

COMMENTS
