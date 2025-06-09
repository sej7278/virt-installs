#!/bin/bash

virt-install \
--virt-type kvm \
--name=alma10v2 \
--os-variant=rhel10.0 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=/kvm/alma10v2.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="AlmaLinux 10.0 (v2)" \
--metadata description='192.168.1.96' \
--location /kvm/AlmaLinux-10.0-x86_64_v2-minimal.iso \
--extra-args='inst.ks=file:alma10_v2.cfg' \
--initrd-inject=alma10_v2.cfg \
--noreboot
