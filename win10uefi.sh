#!/bin/bash

virt-install \
--virt-type kvm \
--name=win10uefi \
--os-variant=win10 \
--vcpus 2 \
--cpu host-passthrough \
--memory 4096 \
--features kvm_hidden=on \
--disk path=~/win10uefi.img,size=50,format=raw,sparse=true,bus=scsi,cache=writethrough,discard=unmap,io=threads  \
--controller type=scsi,model=virtio-scsi \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--network bridge=br0,model=virtio \
--metadata title='Windows 10 (VFIO)' \
--disk ~/virtio-win-0.1.172.iso,device=cdrom \
--cdrom ~/Win10_1903_V2_English_x64.iso \
--graphics none \
--hostdev 02:00.0,address.type=pci,address.multifunction=on \
--hostdev 02:00.1,address.type=pci \
--hostdev 001.003 \
--boot loader=/usr/share/OVMF/OVMF_CODE.fd,loader.readonly=yes,loader.type=pflash



<<COMMENTS

nvidia error 43 workaround - this is a bit naff, but at least it uses virt-install:

    --qemu-commandline='-cpu host,hv_vendor_id=ab1234567890' \

it seems better to do it via "virsh edit":

    <hyperv>
      <vendor_id state="on" value="ab1234567890"/>
    </hyperv>

I'm using raw disk image instead of qcow2 for the moment as there appears to be a bug in qemu 4.1 that is corrupting qcow2 images on win10 at least.

COMMENTS
