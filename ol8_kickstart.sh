#!/bin/bash

virt-install \
--virt-type kvm \
--name=ol8_ks \
--os-variant=ol8.2 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=/tmp/ol8_ks.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="OL 8.4 (kickstart)" \
--location /tmp/OracleLinux-R8-U4-x86_64-dvd.iso \
--extra-args='inst.ks=file:ol8_kickstart.cfg' \
--initrd-inject=ol8_kickstart.cfg \
--noreboot
