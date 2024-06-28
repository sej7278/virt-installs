#!/bin/bash

virt-install \
--name=alma8_arm \
--os-variant=almalinux8 \
--arch aarch64 \
--vcpus 4 \
--memory 2048 \
--disk path=/kvm/alma8_arm.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--metadata title="AlmaLinux 8.4 (aarch64)" \
--location /kvm/AlmaLinux-8.4-aarch64-minimal.iso \
--extra-args='inst.ks=file:alma8_arm.cfg' \
--initrd-inject=alma8_arm.cfg \
--boot loader=/usr/share/AAVMF/AAVMF_CODE.fd,loader_ro=yes,loader_type=pflash,nvram.template=/usr/share/AAVMF/AAVMF_VARS.fd
