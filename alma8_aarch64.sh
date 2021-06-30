#!/bin/bash

virt-install \
--name=alma8_aarch64 \
--os-variant=rhel8.4 \
--arch aarch64 \
--vcpus 4 \
--memory 2048 \
--disk path=~/alma8_aarch64.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--metadata title="AlmaLinux 8.4 (aarch64)" \
--cdrom ~/AlmaLinux-8.4-aarch64-minimal.iso \
--boot loader=/usr/share/AAVMF/AAVMF_CODE.fd,loader_ro=yes,loader_type=pflash,nvram.template=/usr/share/AAVMF/AAVMF_VARS.fd
