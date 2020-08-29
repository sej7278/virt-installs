#!/bin/bash

virt-install \
--virt-type kvm \
--name=windows10 \
--os-variant=win10 \
--vcpus 2 \
--cpu host-passthrough \
--memory 4096 \
--features kvm_hidden=on,hyperv_relaxed=on,hyperv_vapic=on,hyperv_spinlocks=on,hyperv_spinlocks_retries=8191 \
--clock hypervclock_present=yes \
--disk path=~/win10.qcow2,size=50,format=qcow2,sparse=true,bus=scsi,cache=writethrough,discard=unmap,io=threads  \
--controller type=scsi,model=virtio-scsi \
--graphics spice \
--video model=qxl,vgamem=32768,ram=131072,vram=131072,heads=1 \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--network bridge=br0,model=virtio \
--input type=tablet,bus=virtio \
--metadata title='Windows 10' \
--disk ~/virtio-win-0.1.185.iso,device=cdrom \
--cdrom ~/Win10_2004_English_x64.iso \
--boot menu=on
