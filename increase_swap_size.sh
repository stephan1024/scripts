#!/bin/bash

echo "This script might possibly nuke you're whole system, if you dont know what you are doing press ctrl + c now"

sleep 10

if [ -e "/dev/sda4"  ]; then 
	pvcreate /dev/sda4
	pvscan
	vgextend VG0 /dev/sda4
	vgscan
	lvextend -l +100%FREE /dev/VG0/SwpVol
	lvscan
	swapoff -v /dev/VG0/SwpVol
	mkswap /dev/VG0/SwpVol
	swapon -va
else
	cfdisk /dev/sda
	echo "The server will reboot in 5 seconds to effect changes"
	sleep 5
	reboot
fi
