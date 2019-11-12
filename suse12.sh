#!/bin/bash

virt-install \
--virt-type kvm \
--name=suse12 \
--os-variant=sles12sp4 \
--vcpu=1 \
--ram=1024 \
--disk path=~/suse12.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--graphics spice,gl.enable=no,listen=none \--graphics spice \
--video qxl \
--network bridge=br0,model=virtio \
--console pty,target_type=virtio \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--metadata title='SUSE 12sp4' \
--cdrom ~/SLE-12-SP4-Server-DVD-x86_64-GM-DVD1.iso
