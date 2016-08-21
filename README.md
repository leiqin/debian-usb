如果 usb 设备是 /dev/sdb 分区是 /dev/sdb1 挂载在 /media/usb ，
可以用如下命令建立一个 debian 的 Live-usb

    make
    rsync -av dest/ /media/usb
    syslinux -s /dev/sdb1
    dd if=/usr/lib/syslinux/mbr/mbr.bin of=/dev/sdb

- - -

[how-can-i-disable-ati-discrete-graphic-gpu-at-startup-in-ubuntu-14-04-without-bios](http://askubuntu.com/questions/450410/how-can-i-disable-ati-discrete-graphic-gpu-at-startup-in-ubuntu-14-04-without-bi)

In this version of Ubuntu, Dynamic Radeon Drivers are included and activated so that the old solution that you mention does not work.  To operate the old solution you can edit the file /etc/default/grub.  In this file you can add the option radeon.runpm=0 in the call to the current kernel (usually after ro quiet splash).  Alternatively, you can also add radeon.runpm=0 to the value of the variable GRUB\_CMDLINE\_LINUX\_DEFAULT, then save and run sudo update-grub.

