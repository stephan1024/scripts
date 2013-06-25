#!/bin/bash

sfdisk /dev/sdb << EOF
;
EOF

mkfs.ext3 -q /dev/sdb1

mkdir /mnt/sdb1_temp
mount -t ext3 /dev/sdb1 /mnt/sdb1_temp
cp -pr /usr/local/mxit/.bash* /mnt/sdb1_temp
cp -pr /usr/local/mxit/.ssh /mnt/sdb1_temp/

cat /etc/fstab | sed -e 's/\/dev\/mapper\/VG0-AppVol/\/dev\/sdb1/' > /etc/fstab_new
mv /etc/fstab /etc/fstab_old
mv /etc/fstab_new /etc/fstab

umount /mnt/sdb1_temp
umount /usr/local/mxit
mount /usr/local/mxit

lvremove -f /dev/VG0/AppVol
lvscan
lvextend -l +100%FREE /dev/VG0/SysVol

resize2fs /dev/mapper/VG0-SysVol
