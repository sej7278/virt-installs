#!/bin/bash

virt-install \
--virt-type kvm \
--name=centos7_cis \
--os-variant=rhel7.6 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=/data5/kvm/centos/centos7_cis.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="CentOS 7.7 (CIS)" \
--metadata description='192.168.0.91' \
--location /data3/useful_software/unix/centos/CentOS-7.7-x86_64-Everything-1908.iso \
--extra-args='ks=file:centos7_cis.cfg' \
--initrd-inject=centos7_cis.cfg \
--noreboot


<<COMMENTS

mv centos7_cis.qcow2 centos7_cis.qcow2.bak
time qemu-img convert -O qcow2 centos7_cis.qcow2.bak centos7_cis.qcow2
rm centos7_cis.qcow2.bak

COMMENTS
