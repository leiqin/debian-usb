如果 usb 设备是 /dev/sdb 分区是 /dev/sdb1 挂载在 /media/usb ，
可以用如下命令建立一个 debian 的 Live-usb

    make
    rsync -av dest/ /media/usb
    syslinux -s /dev/sdb1
    dd if=/usr/lib/syslinux/mbr/mbr.bin of=/dev/sdb

