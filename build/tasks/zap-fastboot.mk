ZAP_FASTBOOT_PACKAGE := $(PRODUCT_OUT)/ZapOS-$(ZAP_VERSION)-img.zip

.PHONY: updatepackage zap-fastboot
updatepackage: $(INTERNAL_UPDATE_PACKAGE_TARGET)
zap-fastboot: updatepackage
	$(hide) mv $(INTERNAL_UPDATE_PACKAGE_TARGET) $(ZAP_FASTBOOT_PACKAGE)
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
	@echo -e "zip: "$(ZAP_FASTBOOT_PACKAGE)
	@echo -e "size:`ls -lah $(ZAP_FASTBOOT_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e ""
