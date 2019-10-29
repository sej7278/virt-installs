#!/bin/bash

# create vm - fixing selinux bug, then run a basic command
virt-builder fedora-30 \
--format raw \
--output ~/fedora30.img \
--root-password password \
--install rpmdevtools \
--selinux-relabel \
--edit '/usr/lib/systemd/system/selinux-autorelabel.service: $_ = "" if /StandardInput=tty/' \
--firstboot-command 'ls / > /var/tmp/ls.txt' \
--firstboot-command 'poweroff'

# boot vm
qemu-system-x86_64 \
    -enable-kvm \
    -display none \
    -machine accel=kvm:tcg \
    -cpu host \
    -m 2048 \
    -smp 4 \
    -device virtio-scsi-pci,id=scsi \
    -drive file=~/fedora30.img,cache=unsafe,format=raw,id=hd0,if=none \
    -device scsi-hd,drive=hd0 \
    -serial stdio \
    -net nic,model=virtio -net bridge,br=br0

# fetch the file from the guest and delete the disk image
virt-copy-out -a ~/fedora30.img /var/tmp/ls.txt ~/
rm ~/fedora30.img


<<COMMENTS

instead of calling qemu directly, you could use libvirt:

virt-install \
--virt-type kvm \
--name=fedora30 \
--os-variant=fedora30 \
--cpu host-passthrough \
--vcpus 4 \
--memory 2048 \
--disk path=~/fedora30.img,format=raw,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--video none \
--serial=pty \
--metadata title="Fedora 30" \
--import

COMMENTS
