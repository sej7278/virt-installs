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
sed -i "s/##NODE##/${NODE}/g" centos7_k8s.cfg
sed -i "s/##IP##/${IP}/g" centos7_k8s.cfg

# boot from kickstart
virt-install \
--virt-type kvm \
--name="centos7k8s_${NODE}" \
--os-variant=centos7.0 \
--cpu host-passthrough \
--vcpus 2 \
--memory 4096 \
--disk path="/kvm/centos7k8s_${NODE}.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap" \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics none \
--metadata title="CentOS 7.9 (k8s ${NODE})" \
--metadata description="${IP}" \
--location /kvm/CentOS-7.9.2009-x86_64-Everything-2009.iso \
--extra-args='inst.ks=file:centos7_k8s.cfg console=ttyS0' \
--initrd-inject=centos7_k8s.cfg \
--noreboot
