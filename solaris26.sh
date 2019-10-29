qemu-system-sparc -M SS-5 -m 128 -drive file=~/solaris26.qcow2,bus=0,unit=0,media=disk -net nic -net bridge,br=br0


<<COMMENTS

install using:

qemu-img create -f qcow2 ~/solaris26.qcow2 9663676416

qemu-system-sparc -M SS-5 -m 128 -drive file=solaris26.qcow2,bus=0,unit=0,media=disk -drive file=~/solaris-2.6-sparc.iso,bus=0,unit=2,media=cdrom,readonly=on

COMMENTS
