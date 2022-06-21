#!/bin/bash

virt-builder debian-11 \
    --cache /kvm/buildercache \
    --root-password password:password \
    --format qcow2 \
    --hostname localhost \
    --output /kvm/debian11_vb.qcow2 \
    --firstboot-command "dpkg-reconfigure openssh-server"

virt-install \
--virt-type kvm \
--name debian11_vb  \
--os-variant debian11 \
--vcpus 2 \
--cpu host-passthrough \
--ram 4096 \
--disk path=/kvm/debian11_vb.qcow2,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--graphics none \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--metadata title='Debian Bullseye (builder)' \
--import
