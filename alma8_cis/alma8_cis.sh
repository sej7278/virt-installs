#!/bin/bash

virt-install \
--virt-type kvm \
--name=alma8cis \
--os-variant=almalinux8 \
--cpu host-passthrough \
--vcpus 2 \
--memory 4096 \
--disk path=/kvm/alma8cis.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="AlmaLinux 8.8 (CIS)" \
--metadata description='192.168.1.48' \
--location /kvm/AlmaLinux-8.8-x86_64-dvd.iso \
--extra-args='inst.ks=file:alma8_cis.cfg' \
--initrd-inject=alma8_cis.cfg \
--boot loader=/usr/share/OVMF/OVMF_CODE.fd,loader.readonly=yes,loader.type=pflash \
--noreboot
