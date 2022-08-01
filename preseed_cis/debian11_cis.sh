#!/bin/bash

virt-install \
--virt-type kvm \
--name debian11cis  \
--os-variant debian11 \
--vcpus 1 \
--cpu host-passthrough \
--ram 2048 \
--disk path=/kvm/debian11cis.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--graphics none \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--metadata title='Debian Bullseye (CIS)' \
--metadata description='192.168.1.53' \
--location /kvm/debian-11.4.0-amd64-DVD-1.iso \
--initrd-inject=preseed.cfg \
--extra-args='console=tty0 console=ttyS0,115200n8 serial' \
--noreboot

<<COMMENTS

virsh shutdown debian11cis
virt-clone --original debian11cis --name debian11a --file /kvm/debian11a.qcow2
virt-sysprep -d debian11a --edit /etc/network/interfaces:s/53/54/ --edit /etc/hosts:s/53/54/ --edit /etc/hosts:s/11cis/11a/g --edit /etc/hostname:s/11cis/11a/ --firstboot-command "dpkg-reconfigure openssh-server"
virsh start debian11a
virsh console debian11a

COMMENTS
