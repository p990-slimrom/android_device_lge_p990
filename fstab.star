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
/devices/platform/sdhci-tegra.3/mmc_host/mmc0  auto              auto    defaults                                                     voldmanaged=sdcard0:11,nonremovable,noemulatedsd

# external sd
/devices/platform/sdhci-tegra.2/mmc_host/mmc1  auto              auto    defaults                                                     voldmanaged=sdcard1:auto,noemulatedsd
/dev/block/zram0                               none              swap    defaults zramsize=62914560
