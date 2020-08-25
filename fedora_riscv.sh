#!/bin/bash

virt-install \
  --name fedora-riscv \
  --arch riscv64 \
  --vcpus 8 \
  --memory 2048 \
  --os-variant fedora30 \
  --boot kernel=~/Fedora-Developer-Rawhide-20200108.n.0-fw_payload-uboot-qemu-virt-smode.elf \
  --disk path=~/Fedora-Developer-Rawhide-20200108.n.0-sda.raw \
  --network bridge=br0,model=virtio \
  --graphics none \
  --import 

<<COMMENTS

https://fedoraproject.org/wiki/Architectures/RISC-V/Installing

root/riscv = fedora_rocks!

COMMENTS
