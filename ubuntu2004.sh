#!/bin/bash

virt-install \
--virt-type kvm \
--name=ubuntu2004 \
--os-variant=ubuntu20.04 \
--vcpus 4 \
--cpu host-passthrough \
--memory 4096 \
--features kvm_hidden=on \
--disk path=~/ubuntu2004.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap  \
--controller type=scsi,model=virtio-scsi \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--network bridge=br0,model=virtio \
--metadata title='Ubuntu 20.04 (VFIO)' \
--cdrom ~/ubuntu-20.04-desktop-amd64.iso \
--graphics none \
--hostdev 02:00.0,address.type=pci,address.multifunction=on \
--hostdev 02:00.1,address.type=pci \
--hostdev 001.003 \
--boot loader=/usr/share/OVMF/OVMF_CODE.fd,loader.readonly=yes,loader.type=pflash


<<COMMENTS

do not use "3rd party drivers" at install time without the nvidia error43 fix:

virsh edit....

  <features>
    <acpi/>
    <apic/>
    <hyperv>
      <vendor_id state='on' value='ab1234567890'/>
    </hyperv>
    <kvm>
      <hidden state='on'/>
    </kvm>
  </features>

shrink disk image:

mv ubuntu2004.qcow2 ubuntu2004.qcow2.bak
time qemu-img convert -O qcow2 ubuntu2004.qcow2.bak ubuntu2004.qcow2
rm ubuntu2004.qcow2.bak

COMMENTS
