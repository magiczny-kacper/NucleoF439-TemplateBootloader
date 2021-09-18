include mcuboot_files.mk

BOOT_DIR = Bootloader
BOOT_SRC_DIR = $(BOOT_DIR)/Src
BOOT_BIN_DIR = $(BOOT_DIR)/Build
BOOT_OBJ_DIR = $(BOOT_BIN_DIR)/obj

BOOT_HEADERS =
BOOT_HEADERS += -ICommon/Linker/
BOOT_HEADERS += $(MCUBOOT_HEADER_DIR)

BOOT_C_SOURCES =
BOOT_C_SOURCES += $(BOOT_SRC_DIR)/main.c
BOOT_C_SOURCES += $(MCUBOOT_SOURCES)
BOOT_C_FLAGS = -DVECT_TAB_OFFSET=0x08000000
