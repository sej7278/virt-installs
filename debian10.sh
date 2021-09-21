#!/bin/bash

virt-install \
--virt-type kvm \
--name debian10 \
--os-variant debian10 \
--vcpus 1 \
--cpu host-passthrough \
--ram 2048 \
--disk path=~/debian10.qcow2,format=qcow2,size=40,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--soundhw ich6 \
--input tablet,type=virtio \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--metadata title='Debian Buster' \
--filesystem type=mount,mode=passthrough,source=/home/simon/mymount,target=mymount \
--cdrom ~/debian-10.10.0-amd64-DVD-1.iso


<<COMMENTS

on guest to allow filesystem mounting etc:

    sudo apt install qemu-guest-agent spice-vdagent
    sudo  mount -t 9p -o trans=virtio mymount /home/simon/mymount

to fix auto-resizing of the window, run this - not needed with gnome, but is with mate etc:

    xrandr --output Virtual-1 --auto

COMMENTS
