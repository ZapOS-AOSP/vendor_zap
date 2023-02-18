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
    SystemUI \
    Settings 
    
 
 # Battery Optimization tweaks - NOT TESTED 
 # MAY OR MAY NOT WORK FOR YOUR DEVICE
 
 ifeq ($(BUILD_BATTERY_OPT), true)
PRODUCT_PACKAGES += \
    PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    	wifi.supplicant_scan_interval=180 \
    	pm.sleep_mode=1 \
    	power.saving.mode=1 \
    	ro.ril.disable.power.collapse=0 \
    	ro.ril.fast.dormancy.rule=0 \
    	ro.config.hw_power_saving=1
endif

# Extra packages
PRODUCT_PACKAGES += \
    GameSpace

