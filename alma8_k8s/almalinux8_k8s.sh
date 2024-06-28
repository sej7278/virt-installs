#!/bin/bash

# error handler
usage() {
  echo "Usage: $0 -i <ip> -n <node>"
  exit 1
}

# get arguments
while getopts ":i:n:" option
do
  case "${option}" in
    i) IP=${OPTARG};;
    n) NODE=${OPTARG};;
    *) usage;;
  esac
done

# check for correct arguments
if [ -z "${IP}" ] || [ -z "${NODE}" ]; then
  usage
fi

# template kickstart
sed -i "s/##NODE##/${NODE}/g" almalinux8_k8s.cfg
sed -i "s/##IP##/${IP}/g" almalinux8_k8s.cfg

# boot from kickstart
virt-install \
--virt-type kvm \
--name="alma8_k8s_${NODE}" \
--os-variant=almalinux8 \
--cpu host-passthrough \
--vcpus 2 \
--memory 4096 \
--disk path="/kvm/alma8_k8s_${NODE}.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap" \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--metadata title="AlmaLinux 8.10 (k8s-${NODE})" \
--metadata description="${IP}" \
--location /kvm/AlmaLinux-8.10-x86_64-minimal.iso \
--extra-args='inst.ks=file:almalinux8_k8s.cfg console=ttyS0 net.ifnames=0' \
--initrd-inject=almalinux8_k8s.cfg \
--noreboot
