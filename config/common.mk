# Inherit Zap config 
$(call inherit-product, vendor/zap/config/zap_extra.mk)


# Inherit Prebuilt Apps makefile
$(call inherit-product, vendor/zap/extras/config.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    keyguard.no_require_sim=true \
    media.recorder.show_manufacturer_and_model=true \
    net.tethering.noprovisioning=true \
    persist.sys.disable_rescue=true \
    ro.carrier=unknown \
    ro.com.android.dataroaming=false \
    ro.opa.eligible_device=true \
    ro.setupwizard.enterprise_mode=1 \
    ro.storage_manager.enabled=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural

#Set Network Hostname
PRODUCT_PROPERTY_OVERRIDES += \
    net.hostname=$(TARGET_VENDOR_DEVICE_NAME)

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/zap/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/zap/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/zap/prebuilt/common/bin/50-base.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-base.sh

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/zap/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/zap/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/zap/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Copy all zap-specific init rc files
$(foreach f,$(wildcard vendor/zap/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Don't include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
PRODUCT_SYSTEM_SERVER_DEBUG_INFO := false
WITH_DEXPREOPT_DEBUG_INFO := false

# Dedupe VNDK libraries with identical core variants
TARGET_VNDK_USE_CORE_VARIANT := true

# Permissions
PRODUCT_COPY_FILES += \
    vendor/zap/prebuilt/common/etc/permissions/zap-privapp-permissions.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/zap-privapp-permissions.xml \
    vendor/zap/prebuilt/common/etc/permissions/zap-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/zap-power-whitelist.xml

# Charger
PRODUCT_PACKAGES += \
    product_charger_res_images

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/zap/prebuilt/common/etc/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Enable whole-program R8 Java optimizations for SystemUI and system_server,
# but also allow explicit overriding for testing and development.
SYSTEM_OPTIMIZE_JAVA ?= true
SYSTEMUI_OPTIMIZE_JAVA ?= true

# Product overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/zap/overlay
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/zap/overlay
ifneq ($(TARGET_BUILD_GAPPS),true)
PRODUCT_PACKAGE_OVERLAYS += vendor/zap/overlay-vanilla
endif

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# IORap app launch prefetching using Perfetto traces and madvise
PRODUCT_PRODUCT_PROPERTIES += \
    ro.iorapd.enable=true

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# Packages
include vendor/zap/config/packages.mk

# Versioning
include vendor/zap/config/version.mk

# ART
# Optimize everything for preopt
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.systemuicompilerfilter=speed

ifeq ($(TARGET_SUPPORTS_64_BIT_APPS), true)
# Use 64-bit dex2oat for better dexopt time.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat64.enabled=true
endif

PRODUCT_PROPERTY_OVERRIDES += \
    pm.dexopt.boot=verify \
    pm.dexopt.first-boot=verify \
    pm.dexopt.install=speed-profile \
    pm.dexopt.bg-dexopt=everything

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_PROPERTY_OVERRIDES += \
    pm.dexopt.ab-ota=verify
endif

# Disable async MTE on system_server
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    arm64.memtag.process.system_server=off

ifneq ($(wildcard vendor/google/modules/.),)
# Flatten APEXs for performance
OVERRIDE_TARGET_FLATTEN_APEX := true
# This needs to be specified explicitly to override ro.apex.updatable=true from
# # prebuilt vendors, as init reads /product/build.prop after /vendor/build.prop
PRODUCT_PRODUCT_PROPERTIES += ro.apex.updatable=false
endif

ifeq ($(TARGET_BUILD_GAPPS),true)
    $(call inherit-product-if-exists, vendor/google/gms/common/gms-full.mk)
else
    $(call inherit-product-if-exists, vendor/google/pixel/config.mk)
endif

#OTA tools
PRODUCT_HOST_PACKAGES += \
    signapk \
    brotli

# Themes
$(call inherit-product, vendor/themes/common.mk)

# Sepolicy
$(call inherit-product, vendor/zap/config/sepolicy.mk)





