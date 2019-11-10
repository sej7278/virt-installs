#!/bin/bash

virt-install \
--virt-type kvm \
--name debian10 \
--os-variant debian10 \
--vcpus 1 \
--cpu host-passthrough \
--ram 2048 \
--disk path=~/debian10.img,format=raw,size=40,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--graphics spice,gl.enable=no,listen=none \
--video virtio,accel3d=yes \
--soundhw ich6 \
--input tablet,type=virtio \
--network bridge=br0,model=virtio \
--metadata title='Debian Buster' \
--filesystem type=mount,mode=mapped,source=/home/simon/mymount,target=mymount \
--cdrom ~/debian-10.1.0-amd64-DVD-1.iso


<<COMMENTS

on guest to allow filesystem mounting etc:

    sudo apt install qemu-guest-agent spice-vdagent
    sudo  mount -t 9p -o trans=virtio mymount /home/simon/mymount

to fix auto-resizing of the window, run this - not needed with gnome, but is with mate etc:

    xrandr --output Virtual-1 --auto

COMMENTS
