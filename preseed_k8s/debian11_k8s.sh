#!/bin/bash

NODE="master"
IP="192.168.1.69"

virt-install \
--virt-type kvm \
--name deb11_${NODE}  \
--os-variant debian11 \
--vcpus 2 \
--cpu host-passthrough \
--ram 4096 \
--disk path=/kvm/deb11_${NODE}.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--graphics none \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--metadata title="Debian Bullseye (${NODE})" \
--metadata description="${IP}" \
--location /kvm/debian-11.4.0-amd64-DVD-1.iso \
--initrd-inject=preseed.cfg \
--extra-args='console=tty0 console=ttyS0,115200n8 serial' \
--noreboot

<<COMMENTS

virsh shutdown deb11_master
virt-clone --original deb11_master --name deb11_${NODE} --file /kvm/deb11_${NODE}.qcow2
virt-sysprep -d deb11_${NODE} --edit /etc/network/interfaces:s/192.168.1.69/${IP}/ --edit /etc/hosts:s/192.168.1.69/${IP}/ --edit /etc/hosts:s/master/${NODE}/ --edit /etc/hostname:s/master/${NODE}/ --firstboot-command "dpkg-reconfigure openssh-server"
virsh start deb11_${NODE}
virsh console deb11_${NODE}

COMMENTS
