#!/bin/bash

virt-install \
--name=alma9_s390x \
--os-variant=almalinux9 \
--arch s390x \
--vcpus 4 \
--memory 4096 \
--disk path=/kvm/alma9_s390x.qcow2,size=20,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--metadata title="AlmaLinux 9.1 (s390x)" \
--location /kvm/AlmaLinux-9.1-s390x-minimal.iso \
--extra-args='inst.ks=file:alma9_s390x.cfg' \
--initrd-inject=alma9_s390x.cfg \
--noreboot
