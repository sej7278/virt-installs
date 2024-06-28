#!/bin/bash

virt-install \
--virt-type kvm \
--name=centos7_cis \
--os-variant=centos7.0 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=/kvm/centos7_cis.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="CentOS 7.9 (CIS)" \
--metadata description='192.168.0.91' \
--location /kvm/CentOS-7-x86_64-Everything-2207-02.iso \
--extra-args='inst.ks=file:centos7_cis.cfg' \
--initrd-inject=centos7_cis.cfg \
--noreboot

<<COMMENTS

nftables isn't on the DVD so have to use the Everything ISO

COMMENTS
