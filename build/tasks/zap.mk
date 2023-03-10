ZAP_TARGET_PACKAGE := $(PRODUCT_OUT)/ZapOS-$(ZAP_ANDROID_VERSION).zip
SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: otapackage zap bacon
otapackage: $(INTERNAL_OTA_PACKAGE_TARGET)
zap: otapackage
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(ZAP_TARGET_PACKAGE)
	$(hide) $(SHA256) $(ZAP_TARGET_PACKAGE) | cut -d ' ' -f1 > $(ZAP_TARGET_PACKAGE).sha256sum
	$(hide) ./vendor/zap/tools/generate_json_build_info.sh $(ZAP_TARGET_PACKAGE)
	@echo -e ""
	@echo -e "${cya}Building ${bldcya}ZAP${txtrst}";
	@echo -e " ________  ________  ________        ________  ________      "
	@echo -e "|\_____  \|\   __  \|\   __  \      |\   __  \|\   ____\     "
	@echo -e " \|___/  /\ \  \|\  \ \  \|\  \     \ \  \|\  \ \  \___|_    "
	@echo -e "     /  / /\ \   __  \ \   ____\     \ \  \ \  \ \_____  \   "
	@echo -e "    /  /_/__\ \  \ \  \ \  \___|      \ \  \_\  \|____|\  \  "
	@echo -e "   |\________\ \__\ \__\ \__\          \ \_______\____\_\  \ "
	@echo -e "    \|_______|\|__|\|__|\|__|           \|_______|\_________\ "
	@echo -e "                                                 \|_________|"
	@echo -e "                           Get Zapped!                                 "
	@echo -e ""
	@echo -e "zip: "$(ZAP_TARGET_PACKAGE)
	@echo -e "sha256: "${cya}" `cat $(ZAP_TARGET_PACKAGE).sha256sum | cut -d ' ' -f 1`"
	@echo -e "size:`ls -lah $(ZAP_TARGET_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e ""

bacon: zap


