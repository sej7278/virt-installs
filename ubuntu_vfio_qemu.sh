#!/bin/bash

# qemu-img create -f qcow2 ~/ubuntu.qcow2 40G

qemu-system-x86_64 \
    -enable-kvm \
    -m 4G \
    -machine q35,accel=kvm \
    -smp 4,sockets=1,cores=2,threads=2 \
    -cpu host,kvm=off \
    -drive if=pflash,format=raw,readonly,file=/usr/share/OVMF/OVMF_CODE.fd \
    -drive if=pflash,format=raw,file=~/OVMF_VARS.fd \
    -drive id=disk0,if=virtio,file=~/ubuntu.qcow2 \
    -drive file=~/ubuntu-18.04.2-desktop-amd64.iso,index=1,media=cdrom \
    -boot order=dc \
    -vga none \
    -nographic \
    -soundhw hda \
    -net nic,model=virtio -net bridge,br=br0 \
    -device ich9-ahci,id=sata \
    -device pcie-root-port,bus=pcie.0,multifunction=on,port=1,chassis=1,id=port.1 \
    -device vfio-pci,host=02:00.0,multifunction=on \
    -device vfio-pci,host=02:00.1 \
    -usb -device usb-host,hostbus=1,hostaddr=3
