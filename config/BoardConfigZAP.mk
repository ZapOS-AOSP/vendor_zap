include vendor/zap/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/zap/config/BoardConfigQcom.mk
endif

include vendor/zap/config/BoardConfigSoong.mk
