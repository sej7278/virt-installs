#!/bin/bash

virt-install \
--virt-type kvm \
--name=centos5 \
--os-variant=centos5.11 \
--vcpus 1 \
--memory 1024 \
--disk path=~/centos5.qcow2,format=qcow2,sparse=true,bus=sata \
--graphics spice \
--video qxl \
--network bridge=br0,model=virtio \
--metadata title='CentOS 5.11' \
--import


<<COMMENTS

to use the virtio-blk driver, boot the guest with sata configured, then run:

    mkinitrd --with virtio_pci --with virtio_blk -f /boot/initrd-$(uname -r).img $(uname -r)

edit /boot/grub/device.map, replacing sda with vda:

    (hd0)     /dev/vda

then virsh edit the xml and swap from sata to virtio-blk (not virtio-scsi):

    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='~/centos5.qcow2'/>
      <backingStore/>
      <target dev='vda' bus='virtio'/>
      <alias name='virtio-disk0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x08' function='0x0'/>
    </disk>

COMMENTS
