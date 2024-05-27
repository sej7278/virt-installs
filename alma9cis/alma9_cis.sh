#!/bin/bash

virt-install \
--virt-type kvm \
--name=alma9_cis \
--os-variant=almalinux9 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=/kvm/alma9_cis.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="AlmaLinux 9.2 (CIS)" \
--location /kvm/AlmaLinux-9.2-x86_64-dvd.iso \
--extra-args='inst.ks=file:alma9_cis.cfg' \
--initrd-inject=alma9_cis.cfg \
--boot loader=/usr/share/OVMF/OVMF_CODE_4M.fd,loader.readonly=yes,loader.type=pflash \
--noreboot
