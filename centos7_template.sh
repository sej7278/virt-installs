#!/bin/bash

virt-install \
--virt-type kvm \
--name=centos7_template \
--os-variant=rhel7.6 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=~/centos7_template.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--video none \
--metadata title="CentOS 7.7 (template)" \
--location ~/CentOS-7.7-x86_64-Everything-1908.iso \
--extra-args='console=tty0 console=ttyS0,115200n8 serial'

<<COMMENTS

To clone this template to a new VM with its network and other config/logs reset cleanly:

virsh shutdown centos7_template
virt-clone --original centos7_template --name centos7_test --file ~/centos7_test.qcow2
virt-sysprep -d centos7_test
virsh start centos7_test
virsh console centos7_test

COMMENTS
