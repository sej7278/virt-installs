#!/bin/bash

virt-install \
--virt-type kvm \
--name=solaris9 \
--os-variant=solaris9 \
--vcpu=1 \
--cpu host-passthrough \
--ram=512 \
--disk path=/tmp/solaris9.qcow2,size=8,format=qcow2,sparse=true,bus=ide \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--network bridge=br0,model=pcnet \
--metadata title='Solaris 9u8' \
--disk device=cdrom,bus=scsi,boot.order=1,path=/tmp/sol-905-ga-x86-dvd.iso \
--disk device=cdrom,bus=ide,boot.order=2,path=/tmp/sol-905-ga-x86-dvd.iso \
--boot cdrom

<<COMMENTS

need to boot from scsi cdrom to prevent crashing, but then switch to
ide cdrom when asked where to boot solaris kernel from.

scsi controller doesn't work, nor does e1000 nic.

can get install to finish but then it won't boot off of the hdd.

COMMENTS

