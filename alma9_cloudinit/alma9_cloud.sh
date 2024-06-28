#!/bin/bash

virt-install \
--virt-type kvm \
--name=alma9cloud \
--os-variant=almalinux9 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=/kvm/alma9cloud.qcow2,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--metadata title="AlmaLinux 9.0 (cloud-init)" \
--metadata description='192.168.0.47' \
--cloud-init user-data=user-data,meta-data=meta-data \
--import

<<COMMENTS

cp /kvm/AlmaLinux-9-GenericCloud-latest.x86_64.qcow2 /kvm/alma9cloud.qcow2

COMMENTS
