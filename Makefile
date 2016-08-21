# usb iso

.PHONY: usb stable testing config-file stable-amd64 testing-amd64 network

debain_source = https://mirrors.ustc.edu.cn/
ubuntu_source = https://mirrors.ustc.edu.cn/
# ubuntu 16.04
ubuntu_version = xenial

usb:stable testing ubuntu config-file firmware

# debian stable

stable:stable-amd64

network:
	sed -e 's@#debain_source@$(debain_source)@' -e 's@#ubuntu_source@$(ubuntu_source)@' -e 's@#ubuntu_version@$(ubuntu_version)@' download.list | wget -Ncr -nH -i -

stable-amd64:dest/stable/amd64/linux dest/stable/amd64/initrd.gz

dest/stable/amd64/linux:network
	test -d dest/stable/amd64 || mkdir -p dest/stable/amd64
	cp -u debian/dists/stable/main/installer-amd64/current/images/netboot/debian-installer/amd64/linux dest/stable/amd64

dest/stable/amd64/initrd.gz:network
	test -d dest/stable/amd64 || mkdir -p dest/stable/amd64
	cp -u debian/dists/stable/main/installer-amd64/current/images/netboot/debian-installer/amd64/initrd.gz dest/stable/amd64

# debian testing

testing:testing-amd64

testing-amd64:dest/testing/amd64/linux dest/testing/amd64/initrd.gz

dest/testing/amd64/linux:network
	test -d dest/testing/amd64 || mkdir -p dest/testing/amd64
	cp -u debian/dists/unstable/main/installer-amd64/current/images/netboot/debian-installer/amd64/linux dest/testing/amd64

dest/testing/amd64/initrd.gz:network
	test -d dest/testing/amd64 || mkdir -p dest/testing/amd64
	cp -u debian/dists/unstable/main/installer-amd64/current/images/netboot/debian-installer/amd64/initrd.gz dest/testing/amd64

# ubuntu 

ubuntu:ubuntu-amd64

ubuntu-amd64:dest/ubuntu/amd64/linux dest/ubuntu/amd64/initrd.gz

dest/ubuntu/amd64/linux:network
	test -d dest/ubuntu/amd64 || mkdir -p dest/ubuntu/amd64
	cp -u ubuntu/dists/$(ubuntu_version)/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/linux dest/ubuntu/amd64

dest/ubuntu/amd64/initrd.gz:network
	test -d dest/ubuntu/amd64 || mkdir -p dest/ubuntu/amd64
	cp -u ubuntu/dists/$(ubuntu_version)/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/initrd.gz dest/ubuntu/amd64

# config file

config-file:dest/syslinux/vesamenu.c32 dest/syslinux/syslinux.cfg dest/isolinux/isolinux.cfg dest/isolinux/vesamenu.c32

dest/syslinux/vesamenu.c32:/usr/lib/syslinux/modules/bios/vesamenu.c32
	test -d dest/syslinux || mkdir -p dest/syslinux
	cp -u /usr/lib/syslinux/modules/bios/*.c32 dest/syslinux

dest/syslinux/syslinux.cfg:syslinux.cfg
	test -d dest/syslinux || mkdir -p dest/syslinux
	cp -u syslinux.cfg dest/syslinux

dest/isolinux/vesamenu.c32:/usr/lib/syslinux/modules/bios/vesamenu.c32
	test -d dest/isolinux || mkdir -p dest/isolinux
	cp -u /usr/lib/syslinux/modules/bios/*.c32 dest/isolinux

dest/isolinux/isolinux.cfg:syslinux.cfg
	test -d dest/isolinux || mkdir -p dest/isolinux
	cp -u syslinux.cfg dest/isolinux/isolinux.cfg

# firmware

firmware:dest/firmware

dest/firmware:download/firmware.tar.gz
	test -d dest/firmware || mkdir -p dest/firmware
	tar -xzvf download/firmware.tar.gz -C dest/firmware
	touch -r download/firmware.tar.gz dest/firmware

download/firmware.tar.gz:network
	test -d download || mkdir download
	cd download; wget -Nc http://cdimage.debian.org/cdimage/unofficial/non-free/firmware/unstable/current/firmware.tar.gz

