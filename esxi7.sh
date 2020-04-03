#!/bin/sh

virt-install \
--virt-type kvm \
--hvm \
--name esxi7 \
--os-variant=rhel7.0 \
--vcpus 4 \
--cpu host-passthrough \
--machine q35 \
--features kvm_hidden=on \
--ram 16384 \
--disk path=~/esxi7.qcow2,size=10,format=qcow2,sparse=true,bus=sata \
--disk path=~/esxi7data.qcow2,size=100,format=qcow2,sparse=true,bus=sata \
--check disk_size=off \
--graphics spice \
--video qxl \
--network bridge=br0,model=vmxnet3 \
--metadata title='ESXi 7.0' \
--cdrom ~/VMware-VMvisor-Installer-7.0.0-15843807.x86_64.iso
