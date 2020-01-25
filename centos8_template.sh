#!/bin/bash

virt-install \
--virt-type kvm \
--name=centos8_template \
--os-variant=rhel8.0 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=~/centos8_template.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--video none \
--metadata title="CentOS 8.1 (template)" \
--location ~/CentOS-8.1.1911-x86_64-dvd1.iso \
--extra-args='console=tty0 console=ttyS0,115200n8 serial'

<<COMMENTS

systemctl enable fstrim.timer
systemctl start fstrim.timer

ctrl-shift-] to exit virsh console

virsh shutdown centos8_template
virt-clone --original centos8_template --name centos8_test --file ~/centos8_test.qcow2
virt-sysprep -d centos8_test
virsh start centos8_test
virsh console centos8_test

COMMENTS
