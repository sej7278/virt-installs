#!/bin/bash

virt-install \
--virt-type kvm \
--name=win2019 \
--os-variant=win2k19 \
--vcpus 2 \
--cpu host-passthrough \
--features kvm_hidden=on,hyperv_relaxed=on,hyperv_vapic=on,hyperv_spinlocks=on,hyperv_spinlocks_retries=8191 \
--clock hypervclock_present=yes \
--memory 4096 \
--disk path=~/win2019.qcow2,size=50,format=qcow2,sparse=true,bus=scsi,cache=writethrough,discard=unmap,io=threads  \
--controller type=scsi,model=virtio-scsi \
--graphics spice \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--video qxl \
--network bridge=br0,model=virtio \
--input type=tablet,bus=virtio \
--metadata title='Windows 2019 Server' \
--disk ~/virtio-win-0.1.190.iso,device=cdrom \
--cdrom ~/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso \
--boot menu=on
