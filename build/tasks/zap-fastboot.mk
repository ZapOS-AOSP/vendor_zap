ZAP_FASTBOOT_PACKAGE := $(PRODUCT_OUT)/ZapOS-$(ZAP_VERSION)-img.zip

.PHONY: updatepackage zap-fastboot
updatepackage: $(INTERNAL_UPDATE_PACKAGE_TARGET)
zap-fastboot: updatepackage
	$(hide) mv $(INTERNAL_UPDATE_PACKAGE_TARGET) $(ZAP_FASTBOOT_PACKAGE)
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
	@echo -e "zip: "$(ZAP_FASTBOOT_PACKAGE)
	@echo -e "size:`ls -lah $(ZAP_FASTBOOT_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e ""
