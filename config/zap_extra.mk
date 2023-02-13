# ZapOS Specefic Flags
 
 ifeq ($(SHIP_MTK_FM_RADIO), true)
PRODUCT_PACKAGES += \
    RevampedFMRadio
endif

# Speed profile services and wifi-service to reduce RAM and storage
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
# Use a generic profile based boot image by default
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := art/build/boot/boot-image-profile.txt

# SystemUI
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI
