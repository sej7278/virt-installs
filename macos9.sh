# run using:
/usr/bin/qemu-system-ppc -L pc-bios -cpu "g4" -M mac99,via=pmu -m 512 -hda ~/macos9.qcow2 -boot c -g 1024x768x32 -device usb-kbd -device usb-mouse

# install using:
# qemu-system-ppc  -L pc-bios  -cpu "g4"  -M mac99,via=pmu  -m 512  -hda ~/macos9.qcow2  -cdrom "~/macos922_universal_install.iso"  -boot d  -g 1024x768x32  -device usb-kbd  -device usb-mouse
