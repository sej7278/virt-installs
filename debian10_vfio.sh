#!/bin/bash

virt-install \
--virt-type kvm \
--name debian10_vfio \
--os-variant debian10 \
--vcpus 4 \
--cpu host-passthrough \
--ram 4096 \
--disk path=~/debian10_vfio.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--network bridge=br0,model=virtio \
--metadata title='Debian Buster (VFIO)' \
--cdrom ~/debian-10.3.0-amd64-DVD-1.iso \
--graphics none \
--hostdev 02:00.0,address.type=pci,address.multifunction=on \
--hostdev 02:00.1,address.type=pci \
--hostdev 001.003 \
--boot loader=/usr/share/OVMF/OVMF_CODE.fd,loader.readonly=yes,loader.type=pflash
