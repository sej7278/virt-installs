#!/bin/bash

virt-install \
--virt-type kvm \
--name=windows10 \
--os-variant=win10 \
--vcpus 2 \
--cpu host-passthrough \
--memory 4096 \
--features kvm_hidden=on \
--disk path=~/win10.img,size=50,format=raw,sparse=true,bus=scsi,discard=unmap,io=threads  \
--controller type=scsi,model=virtio-scsi \
--graphics spice \
--video model=qxl,vgamem=32768,ram=131072,vram=131072,heads=1 \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--network bridge=br0,model=virtio \
--input type=tablet,bus=virtio \
--metadata title='Windows 10' \
--disk ~/virtio-win-0.1.172.iso,device=cdrom \
--cdrom ~/Win10_1903_V2_English_x64.iso \
--boot menu=on
