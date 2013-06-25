#!/bin/bash

echo "This script might possibly nuke you're whole system, if you dont know what you are doing press ctrl + c now"

sleep 10

if [ -e "/dev/sda3"  ]; then 
	pvcreate /dev/sda3
	pvscan
	vgextend VG0 /dev/sda3
	vgscan
	lvextend -l +100%FREE /dev/VG0/SysVol
	lvscan
	resize2fs /dev/mapper/VG0-SysVol
else
	cfdisk /dev/sda
	echo "The server will reboot in 5 seconds to effect changes"
	sleep 5
	reboot
fi
