#!/bin/bash

virt-install \
--virt-type kvm \
--name=ubuntu1910 \
--os-variant=ubuntu19.04 \
--vcpus 2 \
--cpu host-passthrough \
--memory 4096 \
--features kvm_hidden=on \
--disk path=~/ubuntu_vfio.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,cache=writethrough,discard=unmap,io=threads  \
--controller type=scsi,model=virtio-scsi \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--network bridge=br0,model=virtio \
--metadata title='Ubuntu 19.10 (VFIO)' \
--cdrom ~/ubuntu-19.10-desktop-amd64.iso \
--graphics none \
--hostdev 02:00.0,address.type=pci,address.multifunction=on \
--hostdev 02:00.1,address.type=pci \
--hostdev 001.003 \
--boot loader=/usr/share/OVMF/OVMF_CODE.fd,loader.readonly=yes,loader.type=pflash
