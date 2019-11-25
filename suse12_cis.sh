#!/bin/bash

virt-install \
--virt-type kvm \
--name=suse12_cis \
--os-variant=sles12sp4 \
--vcpu=1 \
--ram=1024 \
--disk path=~/suse12_cis.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--network bridge=br0,model=virtio \
--console pty,target_type=virtio \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--metadata title='SUSE 12sp4 (CIS)' \
--location ~/SLE-12-SP4-Server-DVD-x86_64-GM-DVD1.iso \
--extra-args='autoyast=default' \
--initrd-inject=autoinst.xml


<<COMMENTS

for static ip using nfs instead of initrd-inject:

--extra-args='ifcfg=eth0=192.168.1.3/24,192.168.1.1,192.168.1.1 autoyast=nfs://192.168.1.2/kvm/autoinst.xml'

or dhcp:

--extra-args='netsetup=dhcp autoyast=nfs://192.168.1.2/kvm/autoinst.xml'

COMMENTS
