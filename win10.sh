#!/bin/bash

virt-install \
--virt-type kvm \
--name=windows10 \
--os-variant=win10 \
--vcpus 4,sockets=1,cores=4,threads=1 \
--cpu host-passthrough \
--memory 8192 \
--features smm.state=on,kvm_hidden=on,hyperv_relaxed=on,hyperv_vapic=on,hyperv_spinlocks=on,hyperv_spinlocks_retries=8191 \
--clock hypervclock_present=yes \
--disk path=~/win10.qcow2,size=100,format=qcow2,sparse=true,bus=scsi,cache=writethrough,discard=unmap,io=threads  \
--controller type=scsi,model=virtio-scsi \
--graphics spice \
--video model=qxl,vgamem=32768,ram=131072,vram=131072,heads=1 \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--network bridge=br0,model=virtio \
--input type=tablet,bus=virtio \
--metadata title='Win10 (TPM2 and SB)' \
--disk ~/virtio-win-1.9.16.iso,device=cdrom \
--cdrom ~/Win10_21H1_English_x64.iso \
--tpm type=emulator,version=2.0,model=tpm-tis \
--boot loader=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd,loader.readonly=yes,loader.type=pflash,loader.secure=yes,nvram.template=/usr/share/OVMF/OVMF_VARS_4M.ms.fd,menu=on


<<COMMENTS

virtio-win: https://access.redhat.com/downloads/content/70/ver=/rhel---8.4/8.4/x86_64/packages

to fake your cpu to pass win11 checks:

virsh edit windows10

  <cpu mode="custom" match="exact" check="none">
    <model fallback="forbid">Skylake-Server</model>
  </cpu>

this doesn't work for me, but should according to libvirt (version?):

  --cpu model=Skylake-Server,mode=custom,match=exact,fallback=forbid,check=none \
  
COMMENTS

