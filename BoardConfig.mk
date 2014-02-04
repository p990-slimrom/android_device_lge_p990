# Use a smaller subset of system fonts to keep image size lower
SMALLER_FONT_FOOTPRINT := true

# inherit from the proprietary version
-include device/lge/p990/BoardConfigCommon.mk

# compatibility with old recoveries
USE_SET_METADATA := false

TARGET_BOOTLOADER_BOARD_NAME := p990

BOARD_KERNEL_CMDLINE := 

BOARD_KERNEL_BASE := 0x10000000
BOARD_PAGE_SIZE := 0x00000800

TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00800000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x01400000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 536870912
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1610612736 
BOARD_FLASH_BLOCK_SIZE := 131072

# Try to build the kernel
#TARGET_KERNEL_CONFIG := cyanogenmod_p990_defconfig

TARGET_PREBUILT_KERNEL := device/lge/p990/kernel

BOARD_VOLD_MAX_PARTITIONS := 20

BOARD_HAVE_FM_RADIO := true
BOARD_GLOBAL_CFLAGS += -DHAVE_FM_RADIO

TARGET_OTA_ASSERT_DEVICE := p990
BOARD_RIL_CLASS := ../../../device/lge/p990/ril/

#BOARD_TOUCH_RECOVERY := true

# use the new recovery.fstab
RECOVERY_FSTAB_VERSION = 2

# recovery
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/fsl-tegra-udc/gadget/lun%d/file"
TARGET_RECOVERY_PRE_COMMAND := "/system/bin/setup-recovery"
TARGET_RECOVERY_FSTAB = device/lge/p990/fstab.star

BOARD_HARDWARE_CLASS := device/lge/p990/cmhw/
