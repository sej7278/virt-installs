#!/bin/bash

mv preseed_gui.cfg preseed.cfg

virt-install \
--virt-type kvm \
--name busterpsgui  \
--os-variant debian10 \
--vcpus 1 \
--cpu host-passthrough \
--ram 2048 \
--disk path=~/busterpsgui.qcow2,size=20,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--soundhw ich6 \
--console pty,target_type=virtio \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--input type=tablet,bus=virtio \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--metadata title='Debian Buster (Preseed GUI)' \
--location ~/debian-10.4.0-amd64-DVD-1.iso \
--initrd-inject=preseed.cfg \
--noreboot
