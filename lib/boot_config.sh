#!/bin/bash
###############################################################
### Arch Linux Anywhere Install Script
###	Configure bootloader
###
### Copyright (C) 2017  Dylan Schacht
###
### By: Dylan Schacht (deadhead)
### Email: deadhead3492@gmail.com
### Webpage: http://arch-anywhere.org
###
### Any questions, comments, or bug reports may be sent to above
### email address. Enjoy, and keep on using Arch.
###
### License: GPL v2.0

grub_config() {
	
	if "$crypted" ; then
		sed -i 's!quiet!cryptdevice=/dev/lvm/lvroot:root root=/dev/mapper/root!' "$ARCH"/etc/default/grub
	else
		sed -i 's/quiet//' "$ARCH"/etc/default/grub
	fi

	if "$drm" ; then
		sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/ s/.$/ nvidia-drm.modeset=1"/;s/" /"/' "$ARCH"/etc/default/grub
	fi

	if "$UEFI" ; then
		(arch-chroot "$ARCH" grub-install --efi-directory="$esp_mnt" --target=x86_64-efi --bootloader-id=boot
		mv "$ARCH"/"$esp"/EFI/boot/grubx64.efi "$ARCH"/"$esp"/EFI/boot/bootx64.efi) &> /dev/null &
		pid=$! pri=0.1 msg="\n$grub_load1 \n\n \Z1> \Z2grub-install --efi-directory="$esp_mnt"\Zn" load
				
		if ! "$crypted" ; then
			arch-chroot "$ARCH" mkinitcpio -p linux &> /dev/null &
			pid=$! pri=1 msg="\n$uefi_config_load \n\n \Z1> \Z2mkinitcpio -p linux\Zn" load
		fi
	else
		arch-chroot "$ARCH" grub-install /dev/"$DRIVE" &> /dev/null &
		pid=$! pri=0.1 msg="\n$grub_load1 \n\n \Z1> \Z2grub-install /dev/$DRIVE\Zn" load
	fi
	arch-chroot "$ARCH" grub-mkconfig -o /boot/grub/grub.cfg &> /dev/null &
	pid=$! pri=0.1 msg="\n$grub_load2 \n\n \Z1> \Z2grub-mkconfig -o /boot/grub/grub.cfg\Zn" load

}

syslinux_config() {

	if "$UEFI" ; then
		esp_part_int=$(<<<"$esp_part" grep -o "[0-9]")
		esp_part=$(<<<"$esp_part" grep -o "sd[a-z]")
		esp_mnt=$(<<<$esp_mnt sed "s!$ARCH!!")
		(mkdir -p ${ARCH}${esp_mnt}/EFI/syslinux
		cp -r "$ARCH"/usr/lib/syslinux/efi64/* ${ARCH}${esp_mnt}/EFI/syslinux/
		cp "$aa_dir"/boot/loader/syslinux/syslinux_efi.cfg ${ARCH}${esp_mnt}/EFI/syslinux/syslinux.cfg
		cp "$aa_dir"/boot/splash.png ${ARCH}${esp_mnt}/EFI/syslinux
		arch-chroot "$ARCH" efibootmgr -c -d /dev/"$esp_part" -p "$esp_part_int" -l /EFI/syslinux/syslinux.efi -L "Syslinux") &> /dev/null &
		pid=$! pri=0.1 msg="\n$syslinux_load \n\n \Z1> \Z2syslinux install efi mode...\Zn" load
		
		if [ "$esp_mnt" != "/boot" ]; then
			if [ "$kernel" == "linux" ]; then
				echo -e "$linux_hook\nExec = /usr/bin/cp "$ARCH"/boot/{vmlinuz-linux,initramfs-linux.img,initramfs-linux-fallback.img} ${ARCH}${esp_mnt}" > "$ARCH"/etc/pacman.d/hooks/linux-esp.hook
			elif [ "$kernel" == "linux-lts" ]; then
				echo -e "$lts_hook\nExec = /usr/bin/cp "$ARCH"/boot/{vmlinuz-linux,initramfs-linux.img,initramfs-linux-fallback.img} ${ARCH}${esp_mnt}" > "$ARCH"/etc/pacman.d/hooks/linux-esp.hook
			else
				echo -e "$grs_hook\nExec = /usr/bin/cp "$ARCH"/boot/{vmlinuz-linux,initramfs-linux.img,initramfs-linux-fallback.img} ${ARCH}${esp_mnt}" > "$ARCH"/etc/pacman.d/hooks/linux-esp.hook
			fi
			cp "$ARCH"/boot/{vmlinuz-linux,initramfs-linux.img,initramfs-linux-fallback.img} ${ARCH}${esp_mnt} &
			pid=$! pri=0.1 msg="$wait_load \n\n \Z1> \Z2cp "$ARCH"/boot/vmlinuz-linux ${ARCH}${esp_mnt}\Zn" load
		fi

		if "$crypted" ; then
			sed -i "s|APPEND.*$|APPEND root=/dev/mapper/root cryptdevice=/dev/lvm/lvroot:root rw|" ${ARCH}${esp_mnt}/EFI/syslinux/syslinux.cfg
		else
			sed -i "s|APPEND.*$|APPEND root=/dev/$ROOT|" ${ARCH}${esp_mnt}/EFI/syslinux/syslinux.cfg
		fi

		if "$intel" ; then
			sed -i "s|../../initramfs-linux.img|../../intel-ucode.img,../../initramfs-linux.img|" ${ARCH}${esp_mnt}/EFI/syslinux/syslinux.cfg
		fi
		
		if "$drm" ; then
			sed -i '/APPEND/ s/$/ nvidia-drm.modeset=1/' ${ARCH}${esp_mnt}/EFI/syslinux/syslinux.cfg
		fi

	else
		(syslinux-install_update -i -a -m -c "$ARCH"
		cp "$aa_dir"/boot/loader/syslinux/syslinux.cfg "$ARCH"/boot/syslinux/
		cp "$aa_dir"/boot/splash.png "$ARCH"/boot/syslinux/) &> /dev/null &
		pid=$! pri=0.1 msg="\n$syslinux_load \n\n \Z1> \Z2syslinux-install_update -i -a -m -c $ARCH\Zn" load
		
		if "$crypted" ; then
			sed -i "s|APPEND.*$|APPEND root=/dev/mapper/root cryptdevice=/dev/lvm/lvroot:root rw|" "$ARCH"/boot/syslinux/syslinux.cfg
		else
			sed -i "s|APPEND.*$|APPEND root=/dev/$ROOT|" "$ARCH"/boot/syslinux/syslinux.cfg
		fi

		if "$intel" ; then
			sed -i "s|../initramfs-linux.img|../intel-ucode.img,../initramfs-linux.img|" "$ARCH"/boot/syslinux/syslinux.cfg
		fi

		if "$drm" ; then
			sed -i '/APPEND/ s/$/ nvidia-drm.modeset=1/' ${ARCH}/boot/syslinux/syslinux.cfg
		fi
	fi

}

systemd_config() {

	esp_mnt=$(<<<$esp_mnt sed "s!$ARCH!!")
	(arch-chroot "$ARCH" bootctl --path="$esp_mnt" install
	cp /usr/share/systemd/bootctl/loader.conf ${ARCH}${esp_mnt}/loader/
	echo "timeout 4" >> ${ARCH}${esp_mnt}/loader/loader.conf
	echo -e "title          Arch Linux\nlinux          /vmlinuz-linux\ninitrd         /initramfs-linux.img" > ${ARCH}${esp_mnt}/loader/entries/arch.conf) &> /dev/null &
	pid=$! pri=0.1 msg="\n$syslinux_load \n\n \Z1> \Z2bootctl --path="$esp_mnt" install\Zn" load
	
	if "$crypted" ; then
		echo "options		cryptdevice=/dev/lvm/lvroot:root root=/dev/mapper/root quiet rw" >> ${ARCH}${esp_mnt}/loader/entries/arch.conf
	else
		echo "options		root=PARTUUID=$(blkid -s PARTUUID -o value $(df | grep -m1 "$ARCH" | awk '{print $1}')) rw" >> ${ARCH}${esp_mnt}/loader/entries/arch.conf
	fi

	if "$intel" ; then
		sed -i '/initrd/i\initrd  \/intel-ucode.img' ${ARCH}${esp_mnt}/loader/entries/arch.conf
	fi

	if "$drm" ; then
		sed -i '/options/ s/$/ nvidia-drm.modeset=1/' ${ARCH}${esp_mnt}/loader/entries/arch.conf
	fi

	if [ "$esp_mnt" != "/boot" ]; then
		if [ "$kernel" == "linux" ]; then
			echo -e "$linux_hook\nExec = /usr/bin/cp "$ARCH"/boot/{vmlinuz-linux,initramfs-linux.img,initramfs-linux-fallback.img} ${ARCH}${esp_mnt}" > "$ARCH"/etc/pacman.d/hooks/linux-esp.hook
		elif [ "$kernel" == "linux-lts" ]; then
			echo -e "$lts_hook\nExec = /usr/bin/cp "$ARCH"/boot/{vmlinuz-linux,initramfs-linux.img,initramfs-linux-fallback.img} ${ARCH}${esp_mnt}" > "$ARCH"/etc/pacman.d/hooks/linux-esp.hook
		else
			echo -e "$grs_hook\nExec = /usr/bin/cp "$ARCH"/boot/{vmlinuz-linux,initramfs-linux.img,initramfs-linux-fallback.img} ${ARCH}${esp_mnt}" > "$ARCH"/etc/pacman.d/hooks/linux-esp.hook
		fi
		cp "$ARCH"/boot/{vmlinuz-linux,initramfs-linux.img,initramfs-linux-fallback.img} ${ARCH}${esp_mnt} &
		pid=$! pri=0.1 msg="$wait_load \n\n \Z1> \Z2cp "$ARCH"/boot/vmlinuz-linux ${ARCH}${esp_mnt}\Zn" load
	fi

}