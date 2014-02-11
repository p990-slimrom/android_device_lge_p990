# Android fstab file.
#<src>                                         <mnt_point>       <type>  <mnt_flags and options>                                      <fs_mgr_flags>
# The filesystem that contains the filesystem checker binary (typically /system) cannot
# specify MF_CHECK, and must come before any filesystems that do specify MF_CHECK

# mount points
/dev/block/mmcblk0p12                          /system           ext4    ro,noatime,nosuid                                            wait
/dev/block/mmcblk0p2                           /cache            ext4    noatime,nosuid,nodev,data=writeback,nodelalloc,errors=panic  wait
/dev/block/mmcblk0p9                           /data             ext4    noatime,nosuid,nodev,data=writeback,nodelalloc,errors=panic  wait
/dev/block/mmcblk0p7                           /lgdrm            ext3    noatime,nosuid,nodev,errors=panic                            wait
/dev/block/mmcblk0p6                           /boot             emmc    defaults                                                     recoveryonly
/dev/block/mmcblk0p8                           /recovery         emmc    defaults                                                     recoveryonly
# internal sd
/dev/block/mmcblk0p11                          /sdcard           vfat    defaults                                                     recoveryonly
/devices/platform/sdhci-tegra.3/mmc_host/mmc0  /storage/sdcard0  auto    defaults                                                     voldmanaged=emmc:11,nonremovable
# external sd
/dev/block/mmcblk1p1                           /external_sd      vfat    defaults                                                     recoveryonly
/devices/platform/sdhci-tegra.2/mmc_host/mmc1  /storage/sdcard1  auto    defaults                                                     voldmanaged=sdcard:auto

/dev/block/zram0                               none              swap    defaults zramsize=62914560
