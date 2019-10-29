#!/bin/bash

virt-install \
--virt-type kvm \
--name=junos12 \
--os-variant=freebsd4.11 \
--vcpu=1 \
--ram=1024 \
--disk path=~/junos12.qcow2,format=qcow2,sparse=true \
--graphics none \
--network bridge=br0,model=e1000 \
--metadata title='Junos 12.1' \
--import
