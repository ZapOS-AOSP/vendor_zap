# Copyright (C) 2020 YAAP
# Copyright (C) 2023 ZapOS

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Versioning System
BUILD_DATE := $(shell date +%Y%m%d)
TARGET_PRODUCT_SHORT := $(subst zap_,,$(ZAP_BUILD))


ZAP_BUILDTYPE ?= HOMEMADE
MINOR_VERSION := 1
ZAP_ANDROID_VERSION := $(PLATFORM_VERSION).$(MINOR_VERSION)-$(ZAP_BUILDTYPE)-$(TARGET_PRODUCT_SHORT)-$(BUILD_DATE)
ZAP_BUILD_VERSION := ZapOS-$(PLATFORM_VERSION).$(MINOR_VERSION)
ZAP_VERSION := $(ZAP_BUILD_VERSION)-$(ZAP_BUILDTYPE)-$(TARGET_PRODUCT_SHORT)-$(BUILD_DATE)
ROM_FINGERPRINT := ZAP/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%H%M)


ifeq ($(BUILD_BATTERY_OPT), true)
 
 ZAP_ANDROID_VERSION := $(PLATFORM_VERSION).$(MINOR_VERSION)-$(ZAP_BUILDTYPE)-$(TARGET_PRODUCT_SHORT)-$(BUILD_DATE)-BATTERY
 ZAP_BUILD_VERSION := ZapOS-$(PLATFORM_VERSION).$(MINOR_VERSION)-BATTERY
 ZAP_VERSION := $(ZAP_BUILD_VERSION)-$(ZAP_BUILDTYPE)-$(TARGET_PRODUCT_SHORT)-$(BUILD_DATE)-BATTERY
 
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.zap.build.version=$(ZAP_BUILD_VERSION) \
  ro.zap.build.date=$(BUILD_DATE) \
  ro.zap.buildtype=$(ZAP_BUILDTYPE) \
  ro.zap.fingerprint=$(ROM_FINGERPRINT) \
  ro.zap.version=$(ZAP_VERSION) \
  ro.zap.device=$(ZAP_BUILD) \
  ro.modversion=$(ZAP_VERSION)
  
  
# Signing
ifeq (user,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard .android-certs/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := .android-certs/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard .android-certs/verity.pk8))
PRODUCT_VERITY_SIGNING_KEY := .android-certs/verity
endif
ifneq (,$(wildcard .android-certs/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := .android-certs/otakey.x509.pem
endif
endif
