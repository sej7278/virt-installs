#!/bin/bash

virt-install \
--virt-type kvm \
--name alma8_cloud \
--os-variant=almalinux8 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=/kvm/AlmaLinux-8-GenericCloud-8.4-20210616.x86_64.qcow2,format=qcow2,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--console pty,target_type=virtio \
--metadata title="AlmaLinux 8.4 (cloud)" \
--import \
--cloud-init ssh-key=/home/user/.ssh/id_rsa.pub
