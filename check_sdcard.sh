#!/system/bin/sh

CHECK=$(/system/xbin/blkid /dev/block/mmcblk0p11 | grep vfat)
if [ "$CHECK" == "" ]
then
	/system/bin/newfs_msdos -F 32 /dev/block/mmcblk0p11
fi
