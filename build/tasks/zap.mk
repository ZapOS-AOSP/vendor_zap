ZAP_TARGET_PACKAGE := $(PRODUCT_OUT)/ZapOS-$(ZAP_VERSION).zip
SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: otapackage zap bacon
otapackage: $(INTERNAL_OTA_PACKAGE_TARGET)
zap: otapackage
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(ZAP_TARGET_PACKAGE)
	$(hide) $(SHA256) $(ZAP_TARGET_PACKAGE) | cut -d ' ' -f1 > $(ZAP_TARGET_PACKAGE).sha256sum
	$(hide) ./vendor/zap/tools/generate_json_build_info.sh $(ZAP_TARGET_PACKAGE)
	@echo -e ""
	@echo -e "${cya}Building ${bldcya}ZAP${txtrst}";
	@echo -e "	:::   :::   :::         :::     :::::::::  "
	@echo -e "	:+:   :+: :+: :+:     :+: :+:   :+:    :+: "
	@echo -e "	 +:+ +:+ +:+   +:+   +:+   +:+  +:+    +:+ "
	@echo -e "	  +#++: +#++:++#++: +#++:++#++: +#++:++#+  "
	@echo -e "	   +#+  +#+     +#+ +#+     +#+ +#+        "
	@echo -e "	   #+#  #+#     #+# #+#     #+# #+#        "
	@echo -e "	   ###  ###     ### ###     ### ###        "
	@echo -e "		Yet Another AOSP Project			   "
	@echo -e ""
	@echo -e "zip: "$(ZAP_TARGET_PACKAGE)
	@echo -e "sha256: "${cya}" `cat $(ZAP_TARGET_PACKAGE).sha256sum | cut -d ' ' -f 1`"
	@echo -e "size:`ls -lah $(ZAP_TARGET_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e ""

bacon: zap
