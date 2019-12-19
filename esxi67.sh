#!/bin/sh

virt-install \
--virt-type kvm \
--hvm \
--name esxi67 \
--os-variant=rhel7.0 \
--vcpus 4 \
--cpu host-passthrough \
--machine q35 \
--features kvm_hidden=on \
--ram 16384 \
--disk path=~/esxi67.qcow2,size=400,format=qcow2,sparse=true,bus=sata \
--graphics spice \
--video qxl \
--network bridge=br0,model=e1000 \
--title 'ESXi 6.7' \
--cdrom ~/VMware-VMvisor-Installer-6.7.0.update03-14320388.x86_64.iso


<<COMMENTS

Add to /etc/vmware/config in the guest:

    hv.assumeEnabled = "TRUE"
    vmx.allowNested = "TRUE"

Add to each esxi VM:

    vmx.allowNested = "TRUE" 

COMMENTS
