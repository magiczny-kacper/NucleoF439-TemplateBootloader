include app_files.mk
include boot_files.mk
include mcuboot_files.mk

COMMON_DIR = ./Common
COMMON_ASM_DIR = $(COMMON_DIR)/Startup
COMMON_ASM_SRCS = $(COMMON_ASM_DIR)/startup_stm32f439zitx.s
COMMON_ASM_OBJ = $(BIN_DIR)/obj
COMMON_ASM_OBJS = $(patsubst $(COMMON_ASM_DIR)/%.s, $(COMMON_ASM_OBJ)/%.o, $(COMMON_ASM_SRCS))

COMMON_C_DIR = $(COMMON_DIR)/Src
COMMON_C_SRCS =
COMMON_C_SRCS += $(COMMON_C_DIR)/sysmem.c
COMMON_C_SRCS += $(COMMON_C_DIR)/syscalls.c
COMMON_C_SRCS += $(COMMON_C_DIR)/system_stm32f4xx.c

COMMON_C_HEADERS = -I$(COMMON_C_DIR)/
COMMON_C_HEADERS += -I$(COMMON_DIR)/CMSIS/Include/

# Bootloader variables
# Add common sources to bootloader sources
BOOT_HEADERS += $(COMMON_C_HEADERS)
# Generate list of needed objects
BOOT_OBJS = $(patsubst $(COMMON_C_DIR)/%.c, $(BOOT_OBJ_DIR)/%.o, $(COMMON_C_SRCS))
BOOT_OBJS += $(patsubst $(BOOT_SRC_DIR)/%.c, $(BOOT_OBJ_DIR)/%.o, $(BOOT_C_SOURCES))
# Compiled files name
BOOT_BIN_NAME = $(PROJECT_NAME)_Boot
BOOT_BIN = $(BOOT_BIN_DIR)/$(BOOT_BIN_NAME).bin
BOOT_ELF = $(BOOT_BIN_DIR)/$(BOOT_BIN_NAME).elf

BOOT_LD_FLAGS += -Wl,-Map=$(BOOT_BIN_DIR)/$(BOOT_BIN_NAME).map,--cref -T$(COMMON_DIR)/Linker/STM32F439ZITX_bootloader.ld

# Application variables
# Add common sources to application sources
APP_HEADERS += $(COMMON_C_HEADERS)
# Generate list of needed objects
APP_OBJS = $(patsubst $(COMMON_C_DIR)/%.c, $(APP_OBJ_DIR)/%.o, $(COMMON_C_SRCS))
APP_OBJS += $(patsubst $(APP_SRC_DIR)/%.c, $(APP_OBJ_DIR)/%.o, $(APP_C_SOURCES))
# Compiled files name
APP_BIN_NAME=$(PROJECT_NAME)_App
APP_BIN=$(APP_BIN_DIR)/$(APP_BIN_NAME).bin
APP_ELF=$(APP_BIN_DIR)/$(APP_BIN_NAME).elf

APP_LD_FLAGS = -Wl,-Map=$(APP_BIN_DIR)/$(APP_BIN_NAME).map,--cref -T$(COMMON_DIR)/Linker/STM32F439ZITX_application.ld

# Common variables
BIN_DIR=Build
BIN_NAME=$(PROJECT_NAME)
BIN=$(BIN_DIR)/$(BIN_NAME).bin
