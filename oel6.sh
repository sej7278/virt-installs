#!/bin/bash

virt-install \
--virt-type kvm \
--name=oel6 \
--os-variant=rhel6.9 \
--cpu host-passthrough \
--vcpus 1 \
--memory 1024 \
--disk path=~/oel6.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--video none \
--metadata title="OEL 6.10" \
--location ~/oel6u10_V978757-01.iso \
--extra-args='console=tty0 console=ttyS0,115200n8 serial'
