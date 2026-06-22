# vendor/meizu/meizu_m6/Android.mk
#
# Build Station: prebuilt MODULE declarations for proprietary blobs that the
# in-tree MTK Oreo RIL source (vendor/mediatek/ril, BOARD_PROVIDES_LIBRIL=true)
# links against by module name. These MUST be real modules (not just
# PRODUCT_COPY_FILES) or `libril`/`rild` fail main.mk:732 "missing librilmtk /
# mtk-ril". Mirrors the working vendor/meizu/m2note/Android.mk pattern.
#
# Only librilmtk + mtk-ril are linked by source (FACT: grep across
# vendor/mediatek = 4 refs each, in libril + rild). librilmtkmd2 / mtk-rilmd2 /
# mtk-rilproxy are runtime-only and stay as PRODUCT_COPY_FILES in
# meizu_m6-vendor-blobs.mk. These two are REMOVED from that copy list to avoid a
# duplicate-install collision (module installs to $(TARGET_OUT_VENDOR)/lib*).

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),meizu_m6)

include $(CLEAR_VARS)
LOCAL_MODULE := librilmtk
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/librilmtk.so
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/librilmtk.so
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MULTILIB := both
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := mtk-ril
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/mtk-ril.so
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/mtk-ril.so
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MULTILIB := both
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
include $(BUILD_PREBUILT)

# Preserve any sub-directory makefiles (e.g. camera_compat/).
include $(call first-makefiles-under,$(LOCAL_PATH))

endif
