#!/bin/bash

virt-install \
--virt-type kvm \
--name=win10uefi \
--os-variant=win10 \
--vcpus 16 \
--cpu host-passthrough \
--memory 16384 \
--features kvm_hidden=on,hyperv_relaxed=on,hyperv_vapic=on,hyperv_spinlocks=on,hyperv_spinlocks_retries=8191 \
--clock hypervclock_present=yes \
--disk path=~/win10uefi.qcow2,size=50,format=qcow2,sparse=true,bus=scsi,cache=writethrough,discard=unmap,io=threads  \
--controller type=scsi,model=virtio-scsi \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--network bridge=br0,model=virtio \
--metadata title='Windows 10 (VFIO)' \
--disk ~/virtio-win-0.1.185.iso,device=cdrom \
--cdrom ~/Win10_2004_English_x64.iso \
--graphics none \
--hostdev 02:00.0,address.type=pci,address.multifunction=on \
--hostdev 02:00.1,address.type=pci \
--hostdev 001.003 \
--boot loader=/usr/share/OVMF/OVMF_CODE.fd,loader.readonly=yes,loader.type=pflash



<<COMMENTS

virsh edit win10uefi

    <vendor_id state='on' value='ab1234567890'/>

COMMENTS
