#!/bin/bash

virt-install \
--virt-type kvm \
--name=centos8_cis \
--os-variant=rhel8.0 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=~/centos8_cis.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="CentOS 8.0 (CIS)" \
--location ~/CentOS-8-x86_64-1905-dvd1.iso \
--extra-args='ks=file:centos8_cis.cfg' \
--initrd-inject=centos8_cis.cfg \
--noreboot


<<COMMENTS

mv centos8_cis.qcow2 centos8_cis.qcow2.bak
time qemu-img convert -O qcow2 centos8_cis.qcow2.bak centos8_cis.qcow2
rm centos8_cis.qcow2.bak

COMMENTS
