#!/bin/bash

virt-install \
--name=alma9_ppc \
--os-variant=almalinux9 \
--arch ppc64le \
--machine pseries \
--vcpus 4 \
--memory 4096 \
--disk path=/kvm/alma9_ppc.qcow2,size=20,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--metadata title="AlmaLinux 9.1 (ppc64le)" \
--metadata description='192.168.0.3' \
--location /kvm/AlmaLinux-9.1-ppc64le-minimal.iso \
--extra-args='inst.ks=file:alma9_ppc64le.cfg' \
--initrd-inject=alma9_ppc64le.cfg \
--noreboot
