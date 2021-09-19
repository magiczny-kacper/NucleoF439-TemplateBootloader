MCUBOOT_DIR = Common/External/mcuboot/boot/bootutil
MCUBOOT_SRC_DIR = $(MCUBOOT_DIR)/Src
MCUBOOT_HEADER_DIR = -I$(MCUBOOT_DIR)/include/
MCUBOOT_HEADER_DIR += -ICommon/mcuboot_port/

MCUBOOT_SOURCES =
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/loader.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/boot_record.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/bootutil_misc.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/caps.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/encrypted.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/fault_injection_hardening.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/fault_injection_hardening_delay_rng_mbedtls.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/image_ec.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/image_ec256.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/image_ed25519.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/image_rsa.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/image_validate.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/loader.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/swap_misc.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/swap_move.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/swap_scratch.c
MCUBOOT_SOURCES +=  $(MCUBOOT_SRC_DIR)/tlv.c