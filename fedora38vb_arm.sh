#!/bin/bash

# virt-builder fedora-38 --arch aarch64 --format raw --output /tmp/fedora38_aarch64.img --root-password password 

virt-install \
--name=fedora38_aarch64 \
--os-variant=fedora38 \
--arch aarch64 \
--vcpus 1 \
--memory 2048 \
--disk path=/tmp/fedora38_aarch64.img,format=raw,size=6,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--video none \
--serial=pty \
--metadata title="Fedora 38 (aarch64)" \
--boot loader=/usr/share/AAVMF/AAVMF_CODE.fd,loader_ro=yes,loader_type=pflash,nvram.template=/usr/share/AAVMF/AAVMF_VARS.fd \
--import
