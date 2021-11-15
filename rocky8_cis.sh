#!/bin/bash

virt-install \
--virt-type kvm \
--name=rocky8_cis \
--os-variant=rhel8.4 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=/tmp/rocky8_cis.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="Rocky 8.4 (CIS)" \
--location /tmp/Rocky-8.4-x86_64-minimal.iso \
--extra-args='inst.ks=file:rocky8_cis.cfg' \
--initrd-inject=rocky8_cis.cfg \
--noreboot
