#COMMON_GLOBAL_CFLAGS += -DREVERSE_FFC_MIRROR_LOGIC -DMISSING_EGL_EXTERNAL_IMAGE -DMISSING_EGL_PIXEL_FORMAT_YV12 -DMISSING_GRALLOC_BUFFERS -DEGL_ALWAYS_ASYNC

# inherit from the proprietary version
-include vendor/lge/p990/BoardConfigVendor.mk

TARGET_ARCH := arm
TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := tegra
TARGET_TEGRA_VERSION := t20
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_CPU_VARIANT := generic
TARGET_ARCH_VARIANT := armv7-a
TARGET_ARCH_VARIANT_CPU := cortex-a9
TARGET_ARCH_VARIANT_FPU := vfpv3-d16
ARCH_ARM_HAVE_TLS_REGISTER := true
ARCH_ARM_HIGH_OPTIMIZATION := true
ARCH_ARM_USE_NON_NEON_MEMCPY := true

TARGET_SPECIFIC_HEADER_PATH := device/lge/p990/include

#TARGET_USERIMAGES_USE_EXT4 := true

BOARD_HAS_NO_SELECT_BUTTON := true

#BOARD_USES_CAMERA_LEGACY := true

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

TARGET_OVERLAY_ALWAYS_DETERMINES_FORMAT := true

TARGET_DONT_SET_AUDIO_AAC_FORMAT := true

BOARD_HAS_NO_MISC_PARTITION := true

# Wifi related defines
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA := "/vendor/firmware/fw_bcmdhd.bin"
#WIFI_DRIVER_FW_PATH_AP := "/vendor/firmware/fw_bcmdhd_apsta.bin"

BOARD_HAS_VIBRATOR_IMPLEMENTATION := ../../device/lge/p990/vibrator.c

BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true

TARGET_RECOVERY_PRE_COMMAND := "/system/bin/setup-recovery"

#BOARD_USES_LGE_HDMI_ROTATION := true

BOARD_MOBILEDATA_INTERFACE_NAME := "vsnet0"

# Misc flags
COMMON_GLOBAL_CFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS

# graphics
BOARD_USE_SKIA_LCDTEXT := true
USE_OPENGL_RENDERER := true
BOARD_NO_ALLOW_DEQUEUE_CURRENT_BUFFER := true

# egl
BOARD_EGL_CFG := device/lge/p990/egl.cfg
BOARD_EGL_NEEDS_LEGACY_FB := true
BOARD_USE_MHEAP_SCREENSHOT := true
BOARD_EGL_WORKAROUND_BUG_10194508 := true

TARGET_NEEDS_BLUETOOTH_INIT_DELAY := true
#MAX_EGL_CACHE_ENTRY_SIZE := 0
#MAX_EGL_CACHE_SIZE := 10

# audio
COMMON_GLOBAL_CFLAGS += -DICS_AUDIO_BLOB
TARGET_DONT_SET_AUDIO_AAC_FORMAT := true
BOARD_HAVE_PRE_KITKAT_AUDIO_BLOB := true

# camera
COMMON_GLOBAL_CFLAGS += -DICS_CAMERA_BLOB

BOARD_SYSFS_LIGHT_SENSOR := "/sys/devices/platform/i2c-gpio.5/i2c-5/5-0060/alc"

#TARGET_KERNEL_SOURCE := kernel/lge/star

TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/fsl-tegra-udc/gadget/lun%d/file"
BOARD_BLUEDROID_VENDOR_CONF := device/lge/p990/vnd_bt.txt

# var
TARGET_ARCH_LOWMEM := true
HAVE_SELINUX := false

BOARD_MALLOC_ALIGNMENT := 16
TARGET_EXTRA_CFLAGS := $(call cc-option,-mtune=cortex-a9) $(call cc-option,-mcpu=cortex-a9)

#define to use all of the Linaro Cortex-A9 optimized string funcs,
#instead of subset known to work on all machines
USE_ALL_OPTIMIZED_STRING_FUNCS := true

# Skip droiddoc build to save build time
BOARD_SKIP_ANDROID_DOC_BUILD := true
