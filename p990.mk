DEVICE_PACKAGE_OVERLAYS += device/lge/p990/overlay

$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/device-bcm.mk)

# Board-specific init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ramdisk/init_recovery.rc:root/init_recovery.rc \
    $(LOCAL_PATH)/ramdisk/init.cm-star.rc:root/init.cm-star.rc \
    $(LOCAL_PATH)/ramdisk/init.star.usb.rc:root/init.star.usb.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh \
    $(LOCAL_PATH)/egl.cfg:system/lib/egl/egl.cfg \
    $(LOCAL_PATH)/prebuilt/setup-recovery:system/bin/setup-recovery \
    $(LOCAL_PATH)/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(LOCAL_PATH)/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf

# Audio files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/asound.conf:system/etc/asound.conf \
    $(LOCAL_PATH)/config/audio_policy.conf:system/etc/audio_policy.conf

# media files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/star_synaptics.idc:system/usr/idc/star_synaptics.idc \
    $(LOCAL_PATH)/prebuilt/star_synaptics.kl:system/usr/keylayout/star_synaptics.kl \
    $(LOCAL_PATH)/prebuilt/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/prebuilt/tegra-snd-wm8994.kl:system/usr/keylayout/tegra-snd-wm8994.kl \
    $(LOCAL_PATH)/prebuilt/usb_keyboard_102_en_us.kl:system/usr/keylayout/usb_keyboard_102_en_us.kl \
    $(LOCAL_PATH)/prebuilt/usb_keyboard_102_en_us.kcm.bin:system/usr/keychars/usb_keyboard_102_en_us.kcm.bin

# Permission files that are hardware-specific
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

PRODUCT_PROPERTY_OVERRIDES += \
    ro.bq.gpu_to_cpu_unsupported=1 \
    sys.disable_ext_animation=1 \
    ro.telephony.call_ring.multiple=false \
    ro.telephony.call_ring.delay=3000 \
    ro.telephony.call_ring.absent=true \
    ro.hardware.respect_als=true \
    ro.bt.bdaddr_path=/sys/devices/platform/bd_address/bdaddr_if \
    debug.sf.electron_frames=42 \
    ro.lge.audio_soundexception=true \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15 \
    tf.enable=y \
    drm.service.enabled=true

# force transparent statusbar
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.force_transbar=true

# storage swapping support
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.vold.switchexternal=0 \
    persist.sys.vold.switchablepair=sdcard0,sdcard1

# Graphic glitches fix
PRODUCT_PROPERTY_OVERRIDES += \
   debug.hwui.render_dirty_regions=false

# We want the dalvik-cache to be for system & user apps on the /data partition
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-data-only=1

# Disable camera early graph connect as we can't prebuild graph due to memory
# constraints in whistler.
PRODUCT_PROPERTY_OVERRIDES += \
    nv-camera-disable-early-graph=1

# Do not preload the EGL/GL drivers in Zygote at boot time.
# Our tegra drivers does not seem to support it
PRODUCT_PROPERTY_OVERRIDES += \
    ro.zygote.disable_gl_preload=true

# Disable JIT code cache to free up some ram when the device is running
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.jit.codecachesize=0

# For applications to determine if they should turn off specific memory-intensive
# features that work poorly on low-memory devices.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.low_ram=true

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number. -> Opengles 2.0
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072

$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

$(call inherit-product, build/target/product/full_base_telephony.mk)

PRODUCT_LOCALES += hdpi

## Ugly space-saving hack
PRODUCT_PACKAGES += \
    srec-en
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/10-movestuff.sh:system/addon.d/10-movestuff.sh

## LGE stuffs
PRODUCT_PACKAGES += \
    bridgeutil \
    lights.star \
    libbridge \
    libbridge_jni \
    libemoji \
    screencap \
    audio.a2dp.default \
    audio.usb.default \
    hwcomposer.default \
    com.android.future.usb.accessory

# Enable Torch
PRODUCT_PACKAGES += Torch

PRODUCT_PACKAGES += \
    libnetcmdiface

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp,adb

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_MANUFACTURER := LGE

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_eu.mk)

# Inherit non-open-source blobs.
$(call inherit-product, vendor/lge/p990/p990-vendor.mk)

# Board-specific init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ramdisk/init.p990.rc:root/init.star.rc \
    $(LOCAL_PATH)/ramdisk/ueventd.tegra.rc:root/ueventd.star.rc \
    $(LOCAL_PATH)/ramdisk/fstab.star:root/fstab.star

# TWRP
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/twrp.fstab:recovery/root/etc/twrp.fstab

#Disable SELinux since it needs some more configuration
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.selinux=disabled \
    ro.build.selinux=0

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/charger:root/charger \
    $(foreach f,$(wildcard $(LOCAL_PATH)/prebuilt/res/images/charger/*),$(f):root/res/images/charger/$(notdir $(f))) \
    $(foreach f,$(wildcard $(LOCAL_PATH)/prebuilt/res/images/security/*),$(f):root/res/images/security/$(notdir $(f)))

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.vsnet:system/bin/init.vsnet \
    $(LOCAL_PATH)/init.vsnet-down:system/bin/init.vsnet-down \
    $(LOCAL_PATH)/gps_brcm_conf.xml:system/etc/gps_brcm_conf.xml

# Build kernel module instead of copying
#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/prebuilt/wireless.ko:system/lib/modules/wireless.ko

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
    $(LOCAL_PATH)/kernel/kowalski/alsa_amixer:system/xbin/alsa_amixer \
    $(LOCAL_PATH)/kernel/kowalski/iwconfig:system/xbin/iwconfig \
    $(LOCAL_PATH)/kernel/kowalski/iwlist:system/xbin/iwlist

PRODUCT_PACKAGES += \
    lgcpversion

PRODUCT_NAME := full_p990
PRODUCT_DEVICE := p990
PRODUCT_MODEL := LG-P990
