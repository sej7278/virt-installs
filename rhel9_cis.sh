#!/bin/bash

virt-install \
--virt-type kvm \
--name=rhel9_cis \
--os-variant=rhel9.0 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=/kvm/rhel9_cis.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="RHEL 9.0 (CIS)" \
--location /rhel-baseos-9.0-x86_64-dvd.iso \
--extra-args='inst.ks=file:rhel9_cis.cfg' \
--initrd-inject=rhel9_cis.cfg \
--noreboot
