LOCAL_PATH := $(call my-dir)

CORE_DIR := $(LOCAL_PATH)/..

include $(CORE_DIR)/Makefile.common

COREFLAGS := -D__LIBRETRO__ -DFRONTEND_SUPPORTS_RGB565 $(INCFLAGS)

GIT_VERSION := " $(shell git rev-parse --short HEAD || echo unknown)"
ifneq ($(GIT_VERSION)," unknown")
  COREFLAGS += -DGIT_VERSION=\"$(GIT_VERSION)\"
endif

include $(CLEAR_VARS)
LOCAL_MODULE    := retro
# HIER DIE ÄNDERUNG: Sowohl C- als auch C++ Dateien einbinden
LOCAL_SRC_FILES := $(SOURCES_CXX) $(SOURCES_C)
LOCAL_CPP_FEATURES := exceptions
LOCAL_CFLAGS    := $(COREFLAGS)
LOCAL_CPPFLAGS  := $(COREFLAGS) -std=c++17
LOCAL_LDFLAGS   := -Wl,-version-script=$(CORE_DIR)/libretro/link.T
include $(BUILD_SHARED_LIBRARY)