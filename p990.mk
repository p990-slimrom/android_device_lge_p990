# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_eu.mk)

$(call inherit-product, device/lge/p990/star.mk)

DEVICE_PACKAGE_OVERLAYS += device/lge/p990/overlay

# Inherit non-open-source blobs.
$(call inherit-product-if-exists, vendor/lge/p990/p990-vendor.mk)

# Board-specific init
PRODUCT_COPY_FILES += \
    device/lge/p990/init.p990.rc:root/init.star.rc \
    $(LOCAL_PATH)/ueventd.tegra.rc:root/ueventd.star.rc \
    $(LOCAL_PATH)/fstab.p990:root/fstab.star

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.vsnet:system/bin/init.vsnet \
    $(LOCAL_PATH)/init.vsnet-down:system/bin/init.vsnet-down \
    $(LOCAL_PATH)/gps_brcm_conf.xml:system/etc/gps_brcm_conf.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/check_sdcard.sh:system/bin/check_sdcard.sh \
    $(LOCAL_PATH)/lgdrm.img:system/bin/lgdrm.img

# prebuilt kernel stuff
LOCAL_KERNEL := device/lge/p990/kernel/zImage

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel \
    $(LOCAL_PATH)/kernel/bthid.ko:system/lib/modules/bthid.ko \
    $(LOCAL_PATH)/kernel/zram.ko:system/lib/modules/zram.ko

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/kernel/kowalski/power.tegra.so:system/lib/hw/power.tegra.so \
    $(LOCAL_PATH)/kernel/kowalski/KowalskiManager.apk:system/app/KowalskiManager.apk \
    $(LOCAL_PATH)/kernel/kowalski/95kowalski:system/etc/init.d/95kowalski \
    $(LOCAL_PATH)/kernel/kowalski/alsa_amixer:system/xbin/alsa_amixer

PRODUCT_PACKAGES += \
    lgcpversion

PRODUCT_NAME := full_p990
PRODUCT_DEVICE := p990
PRODUCT_MODEL := LG-P990
