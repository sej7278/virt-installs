# virt-installs
libvirt scripts for various operating systems


#### Install on debian host:
```
apt install qemu-kvm libvirt-daemon libvirt-clients libvirt-daemon-system virtinst \
libosinfo-bin bridge-utils virt-top libguestfs-tools libosinfo-bin  qemu-system virt-manager \
remmina-plugin-spice virt-viewer spice-client-gtk spice-vdagent
```

#### Allow bridging as non-root:
```
chmod u+s /usr/lib/qemu/qemu-bridge-helper
mkdir /etc/qemu
echo "allow br0" > /etc/qemu/bridge.conf
```

#### Switch from kvm to virtualbox:
```
rmmod kvm_intel
rmmod kvm
modprobe vboxdrv
modprobe vboxnetflt
```

#### Exit virsh console:
```
ctrl-shift-]
```

#### Convert disk from virtualbox:
```
qemu-img convert -f vdi -O qcow2 win10.vdi -p -S 512 win10.qcow2
```

#### List all --os-variant's:
```
osinfo-query os
```

#### List all --cpu models:
```
virsh cpu-models x86_64
cat /usr/share/libvirt/cpu_map.xml
```

#### To fix pci passthrough as non-root, add this to /etc/rc.local:
```
chmod 666 /sys/bus/pci/devices/0000:02:00.0/config
chmod 666 /sys/bus/pci/devices/0000:02:00.1/config
```

#### To prevent drivers binding before vfio-pci add this to /etc/modprobe.d/kvm-intel.conf (not grub.cfg like a lot of Arch tutorials!):
```
options vfio-pci ids=10de:128b,10de:0e0f
softdep nouveau pre: vfio-pci
softdep snd_hda_intel pre: vfio-pci
```

#### To pass through a usb keyboard/mouse add this to /etc/udev/rules.d/99-qemu.rules:
```
SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"
SUBSYSTEM=="usb", ATTR{idVendor}=="04f2", ATTR{idProduct}=="0963", MODE="0666" 
SUBSYSTEM=="usb", ATTR{idVendor}=="04f2", ATTR{idProduct}=="0963", MODE="0666" 
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="00cb", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c312", MODE="0666" 
```
