# usb iso

.PHONY: usb stable testing config-file stable-i386 stable-amd64 testing-i386 testing-amd64 network

source = http://ftp.cn.debian.org

usb:stable testing live config-file firmware

stable:stable-i386 stable-amd64

stable-i386:dest/stable/i386/linux dest/stable/i386/initrd.gz

dest/stable/i386/linux:network
	test -d dest/stable/i386 || mkdir -p dest/stable/i386
	cd dest/stable/i386; wget -Nc $(source)/debian/dists/stable/main/installer-i386/current/images/netboot/debian-installer/i386/linux

dest/stable/i386/initrd.gz:network
	test -d dest/stable/i386 || mkdir -p dest/stable/i386
	cd dest/stable/i386; wget -Nc $(source)/debian/dists/stable/main/installer-i386/current/images/netboot/debian-installer/i386/initrd.gz

stable-amd64:dest/stable/amd64/linux dest/stable/amd64/initrd.gz

dest/stable/amd64/linux:network
	test -d dest/stable/amd64 || mkdir -p dest/stable/amd64
	cd dest/stable/amd64; wget -Nc $(source)/debian/dists/stable/main/installer-amd64/current/images/netboot/debian-installer/amd64/linux

dest/stable/amd64/initrd.gz:network
	test -d dest/stable/amd64 || mkdir -p dest/stable/amd64
	cd dest/stable/amd64; wget -Nc $(source)/debian/dists/stable/main/installer-amd64/current/images/netboot/debian-installer/amd64/initrd.gz

testing:testing-i386 testing-amd64

testing-i386:dest/testing/i386/linux dest/testing/i386/initrd.gz

dest/testing/i386/linux:network
	test -d dest/testing/i386 || mkdir -p dest/testing/i386
	cd dest/testing/i386; wget -Nc $(source)/debian/dists/unstable/main/installer-i386/current/images/netboot/debian-installer/i386/linux

dest/testing/i386/initrd.gz:network
	test -d dest/testing/i386 || mkdir -p dest/testing/i386
	cd dest/testing/i386; wget -Nc $(source)/debian/dists/unstable/main/installer-i386/current/images/netboot/debian-installer/i386/initrd.gz

testing-amd64:dest/testing/amd64/linux dest/testing/amd64/initrd.gz

dest/testing/amd64/linux:network
	test -d dest/testing/amd64 || mkdir -p dest/testing/amd64
	cd dest/testing/amd64; wget -Nc $(source)/debian/dists/unstable/main/installer-amd64/current/images/netboot/debian-installer/amd64/linux

dest/testing/amd64/initrd.gz:network
	test -d dest/testing/amd64 || mkdir -p dest/testing/amd64
	cd dest/testing/amd64; wget -Nc $(source)/debian/dists/unstable/main/installer-amd64/current/images/netboot/debian-installer/amd64/initrd.gz

live:iso_file = $(shell w3m -dump $(source)/debian-cd/current-live/i386/iso-hybrid/ | sed -rn 's/(xfce-desktop.iso)\b[^.].*/\1/p')

live:dest/live

dest/live:download/debian-live-xfce-desktop.iso
	test -d dest || mkdir dest
	cd dest; 7z x ../download/debian-live-xfce-desktop.iso live isolinux/isolinux.bin isolinux/boot.cat
	touch -r download/debian-live-xfce-desktop.iso dest/live

download/debian-live-xfce-desktop.iso:network
	@echo 'iso_file' $(iso_file)
	test -d download || mkdir download
	cd download; wget -Nc $(source)/debian-cd/current-live/i386/iso-hybrid/$(iso_file)
	cd download; ln -f $(iso_file) debian-live-xfce-desktop.iso

config-file:dest/syslinux/vesamenu.c32 dest/syslinux/syslinux.cfg dest/isolinux/isolinux.cfg dest/isolinux/vesamenu.c32

dest/syslinux/vesamenu.c32:/usr/lib/syslinux/vesamenu.c32
	test -d dest/syslinux || mkdir -p dest/syslinux
	cp /usr/lib/syslinux/vesamenu.c32 dest/syslinux

dest/syslinux/syslinux.cfg:syslinux.cfg
	test -d dest/syslinux || mkdir -p dest/syslinux
	cp syslinux.cfg dest/syslinux

dest/isolinux/vesamenu.c32:/usr/lib/syslinux/vesamenu.c32
	test -d dest/isolinux || mkdir -p dest/isolinux
	cp /usr/lib/syslinux/vesamenu.c32 dest/isolinux

dest/isolinux/isolinux.cfg:syslinux.cfg
	test -d dest/isolinux || mkdir -p dest/isolinux
	cp syslinux.cfg dest/isolinux/isolinux.cfg

firmware:dest/firmware

dest/firmware:download/firmware.tar.gz
	test -d dest/firmware || mkdir -p dest/firmware
	tar -xzvf download/firmware.tar.gz -C dest/firmware
	touch -r download/firmware.tar.gz dest/firmware

download/firmware.tar.gz:network
	test -d download || mkdir download
	cd download; wget -Nc http://cdimage.debian.org/cdimage/unofficial/non-free/firmware/unstable/current/firmware.tar.gz
