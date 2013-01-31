If the usb device is /dev/sdb and the partition is /dev/sdb1 mount point is /media/usb

    make
    cp -r dest/* /media/usb
    syslinux -s /dev/sdb1
    dd if=/usr/lib/syslinux/mbr.bin of=/dev/sdb

make iso image

    sudo genisoimage -r -V "debian-live" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o "debian-live.iso" dest


this work is in the public domain; it can be used for whatever purpose with absolutely no restrictions.
