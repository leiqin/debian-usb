如果 usb 设备是 /dev/sdb 分区是 /dev/sdb1 挂载在 /media/usb ，
可以用如下命令建立一个 debian 的 Live-usb

    make
    rsync -av dest/ /media/usb
    syslinux -s /dev/sdb1
    dd if=/usr/lib/syslinux/mbr/mbr.bin of=/dev/sdb

如果要制作光盘镜像，可以使用这条命令：

    sudo genisoimage -r -V "debian-installer" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o "debian-installer.iso" dest

this work is in the public domain; it can be used for whatever purpose with absolutely no restrictions.
