如果 usb 设备是 /dev/sdb 分区是 /dev/sdb1 挂载在 /media/usb ，
可以用如下命令建立一个 debian 的 Live-usb

    make
    rsync -av dest/ /media/usb
    syslinux -s /dev/sdb1
    dd if=/usr/lib/syslinux/mbr/mbr.bin of=/dev/sdb

如果要制作光盘镜像，可以使用这条命令：

    sudo genisoimage -r -V "debian-live" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o "debian-live.iso" dest

如果需要修改 Live-usb 中安装的软件，可以这么做：

dest/live/filesystem.squashfs 是文件系统的压缩镜像，将其解压

    sudo unsquashfs dest/live/filesystem.squashfs

会在当前目录生成一个 squashfs-root 的子目录，然后 chroot

    sudo chroot squashfs-root

安装或删除自己需要的软件，完成之后在把它压缩回去，需要先删除或者移动原来的 filesystem.squashfs 文件

    sudo rm dest/live/filesystem.squashfs
    sudo mksquashfs squashfs-root dest/live/filesystem.squashfs

然后重复上述动作：

    cp -r dest/* /media/usb

或者

    sudo genisoimage -r -V "debian-live" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o "debian-live.iso" dest
    

this work is in the public domain; it can be used for whatever purpose with absolutely no restrictions.
