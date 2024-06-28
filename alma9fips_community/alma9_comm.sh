#!/bin/bash

virt-install \
--virt-type kvm \
--name=alma9comm \
--os-variant=almalinux9 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=/kvm/alma9comm.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="AlmaLinux 9.2 (FIPS community)" \
--metadata description='192.168.0.79' \
--location /kvm/AlmaLinux-9.2-x86_64-dvd.iso \
--extra-args='inst.ks=file:alma9_comm.cfg' \
--initrd-inject=alma9_comm.cfg \
--tpm type=emulator,version=2.0,model=tpm-tis \
--features smm.state=on \
--boot menu=on,loader=/usr/share/OVMF/OVMF_CODE_4M.ms.fd,loader.readonly=yes,loader.type=pflash,loader.secure=yes,nvram.template=/usr/share/OVMF/OVMF_VARS_4M.ms.fd \
--noreboot
