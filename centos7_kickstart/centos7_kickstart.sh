#!/bin/bash

VMNAME="kickstart"

virt-install \
--virt-type kvm \
--name=centos7_${VMNAME} \
--os-variant=centos7.0 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=/kvm/centos7_${VMNAME}.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="CentOS 7.9 (${VMNAME})" \
--location /kvm/CentOS-7.9.2009-x86_64-Everything-2009.iso \
--extra-args='inst.ks=file:centos7_kickstart.cfg' \
--initrd-inject=centos7_kickstart.cfg \
--noreboot
