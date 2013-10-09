LOCAL_PATH:= $(call my-dir)

ifeq ($(WIFI_DRIVER_HAS_LGE_SOFTAP),true)
  LOCAL_CFLAGS += -DLGE_SOFTAP

NETD_SUPPL_DIR = system/netd

NETD_SUPPL_DIR_INCLUDE = $(NETD_SUPPL_DIR)

########################

include $(CLEAR_VARS)
LOCAL_MODULE := netd
#LOCAL_SHARED_LIBRARIES := libc libcutils
LOCAL_CFLAGS := $(L_CFLAGS)
LOCAL_SRC_FILES := CommandListener.cpp SoftapController.cpp
LOCAL_C_INCLUDES := $(NETD_SUPPL_DIR_INCLUDE)
include $(BUILD_STATIC_LIBRARY)

########################

endif
