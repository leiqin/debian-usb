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
	mkdir -p download
	cd download; sed -e 's@#debain_source@$(debain_source)@' -e 's@#ubuntu_source@$(ubuntu_source)@' -e 's@#ubuntu_version@$(ubuntu_version)@' ../download.list | wget -Ncr -nH -i -

stable-amd64:
	mkdir -p dest/installer/stable/amd64
	cp -u download/debian/dists/stable/main/installer-amd64/current/images/netboot/debian-installer/amd64/linux dest/installer/stable/amd64
	cp -u download/debian/dists/stable/main/installer-amd64/current/images/netboot/debian-installer/amd64/initrd.gz dest/installer/stable/amd64

# debian testing

testing:testing-amd64

testing-amd64:
	mkdir -p dest/installer/testing/amd64
	cp -u download/debian/dists/unstable/main/installer-amd64/current/images/netboot/debian-installer/amd64/linux dest/installer/testing/amd64
	cp -u download/debian/dists/unstable/main/installer-amd64/current/images/netboot/debian-installer/amd64/initrd.gz dest/installer/testing/amd64

# ubuntu 

ubuntu:ubuntu-amd64

ubuntu-amd64:
	mkdir -p dest/installer/ubuntu/amd64
	cp -u download/ubuntu/dists/$(ubuntu_version)/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/linux dest/installer/ubuntu/amd64
	cp -u download/ubuntu/dists/$(ubuntu_version)/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/initrd.gz dest/installer/ubuntu/amd64

# config file

config-file:dest/syslinux/vesamenu.c32 dest/syslinux/syslinux.cfg dest/isolinux/isolinux.cfg dest/isolinux/vesamenu.c32

dest/syslinux/vesamenu.c32:/usr/lib/syslinux/modules/bios/vesamenu.c32
	mkdir -p dest/syslinux
	cp -u /usr/lib/syslinux/modules/bios/*.c32 dest/syslinux

dest/syslinux/syslinux.cfg:syslinux.cfg
	mkdir -p dest/syslinux
	cp -u syslinux.cfg dest/syslinux

dest/isolinux/vesamenu.c32:/usr/lib/syslinux/modules/bios/vesamenu.c32
	mkdir -p dest/isolinux
	cp -u /usr/lib/syslinux/modules/bios/*.c32 dest/isolinux

dest/isolinux/isolinux.cfg:syslinux.cfg
	mkdir -p dest/isolinux
	cp -u syslinux.cfg dest/isolinux/isolinux.cfg

# firmware

firmware:dest/firmware

dest/firmware:download/cdimage/unofficial/non-free/firmware/unstable/current/firmware.tar.gz
	mkdir -p dest/firmware
	tar -xzvf download/cdimage/unofficial/non-free/firmware/unstable/current/firmware.tar.gz -C dest/firmware
	touch -r download/cdimage/unofficial/non-free/firmware/unstable/current/firmware.tar.gz dest/firmware

download/firmware.tar.gz:network

# clean

clean:clean-dest clean-download

clean-dest:
	rm -rf dest

clean-download:
	rm -rf download
