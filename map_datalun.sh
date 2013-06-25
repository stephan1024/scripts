#!/bin/bash

sfdisk /dev/sdb << EOF
;
EOF

mkfs.ext3 -q /dev/sdb1

mkdir /mnt/data

echo "/dev/sdb1               /mnt/data               ext3    defaults,noatime        0 0" >> /etc/fstab
mount /mnt/data
