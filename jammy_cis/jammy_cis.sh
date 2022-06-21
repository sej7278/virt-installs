#!/bin/bash

virt-install \
--virt-type kvm \
--name=jammy_cis \
--os-variant=ubuntu21.04 \
--vcpus 1 \
--cpu host-passthrough \
--memory 2048 \
--features smm.state=on \
--disk path=/kvm/jammy_cis.qcow2,size=50,format=qcow2,sparse=true,bus=scsi,discard=unmap  \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--metadata title='Ubuntu 22.04 (CIS)' \
--disk path=/kvm/seed.iso,device=cdrom,bus=sata \
--location /kvm/ubuntu-22.04-live-server-amd64.iso,kernel=casper/vmlinuz,initrd=casper/initrd \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--tpm type=emulator,version=2.0,model=tpm-tis \
--boot loader=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd,loader.readonly=yes,loader.type=pflash,loader.secure=yes,nvram.template=/usr/share/OVMF/OVMF_VARS_4M.ms.fd \
--extra-args='autoinstall' \
--noreboot

virsh change-media jammy_cis sdc --eject --force
