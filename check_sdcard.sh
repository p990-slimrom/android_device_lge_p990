#!/system/bin/sh

CHECK=$(/system/xbin/blkid /dev/block/mmcblk0p11 | grep vfat)
if [ "$CHECK" == "" ]
then
	/system/bin/newfs_msdos -F 32 /dev/block/mmcblk0p11
fi

CHECK=$(/system/xbin/blkid /dev/block/mmcblk0p7 | grep ext3)
if [ "$CHECK" == "" ]
then
	/sbin/dd if=/tmp/lgdrm.img of=/dev/block/mmcblk0p7
fi
