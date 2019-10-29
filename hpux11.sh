qemu-system-hppa -boot c -serial mon:stdio -nographic -drive if=scsi,bus=0,index=6,file=~/hpux.img,format=raw -m 512 -net nic -net bridge,br=br0

<<COMMENTS

install:
qemu-system-hppa -boot d -serial telnet::4441,server -drive if=scsi,bus=0,index=6,file=hpux.img,format=raw -serial mon:stdio -D /tmp/foo -nographic -m 512 -d nochain -cdrom hp-ux-1of4.iso -D /tmp/foo -net nic -net bridge,br=br0

switch cd from qemu monitor:
(qemu) eject -f scsi0-cd2
(qemu) change scsi0-cd2 hp-ux-4of4.iso
(qemu) info block

skip hung nfs on boot:
control shift \

COMMENTS
