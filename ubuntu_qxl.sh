#!/bin/bash

# qemu-img create -f qcow2 ~/ubuntu.qcow2 40G

qemu-system-x86_64 \
    -enable-kvm \
    -m 4G \
    -machine q35,accel=kvm \
    -smp 4,sockets=1,cores=2,threads=2 \
    -cpu host,kvm=off \
    -device virtio-scsi-pci,id=scsi0 \
    -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,device_id=drive-scsi0-0-0-0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0 \
    -drive if=pflash,format=raw,readonly,file=/usr/share/OVMF/OVMF_CODE.fd \
    -drive if=pflash,format=raw,file=~/OVMF_VARS.fd \
    -drive file=~/ubuntu.qcow2,if=none,id=drive-scsi0-0-0-0,discard=unmap \
    -drive file=~/ubuntu-18.04.2-desktop-amd64.iso,index=1,media=cdrom \
    -boot order=dc \
    -vga qxl \
    -soundhw hda \
    -net nic,model=virtio -net bridge,br=br0 \
    -device ich9-ahci,id=sata \
    -usb -device usb-tablet
