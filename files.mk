
COMMON_DIR = Common
COMMON_ASM_DIR = $(COMMON_DIR)/Startup
COMMON_ASM_SRCS = $(COMMON_ASM_DIR)/startup_stm32f439zitx.s
COMMON_ASM_OBJ = $(BIN_DIR)/obj
COMMON_ASM_OBJS = $(patsubst $(COMMON_ASM_DIR)/%.s, $(COMMON_ASM_OBJ)/%.o, $(COMMON_ASM_SRCS))

COMMON_C_DIR = $(COMMON_DIR)/Src
COMMON_C_SRCS =
COMMON_C_SRCS += $(COMMON_C_DIR)/sysmem.c
COMMON_C_SRCS += $(COMMON_C_DIR)/syscalls.c
COMMON_C_SRCS += $(COMMON_C_DIR)/system_stm32f4xx.c

COMMON_SRCS = $(COMMON_ASM_SRCS) + $(COMMON_C_SRCS)

COMMON_C_HEADERS = -I$(COMMON_C_DIR)/
COMMON_C_HEADERS += -I$(COMMON_DIR)/Include/
COMMON_C_HEADERS += -I$(COMMON_DIR)/CMSIS/Include/

include app_files.mk
include boot_files.mk
include mcuboot_files.mk

# Bootloader variables
BOOT_HEADERS += $(COMMON_C_HEADERS)
# Add common sources to bootloader sources
BOOT_C_SOURCES += $(COMMON_C_SRCS)
# Generate list of needed objects
BOOT_OBJS = $(addprefix $(BOOT_OBJ_DIR)/, $(notdir $(COMMON_ASM_SRCS:.s=.o)))
BOOT_OBJS += $(addprefix $(BOOT_OBJ_DIR)/, $(notdir $(BOOT_C_SOURCES:.c=.o)))
# Compiled files name
BOOT_BIN_NAME = $(PROJECT_NAME)_Boot
BOOT_BIN = $(BOOT_BIN_DIR)/$(BOOT_BIN_NAME).bin
BOOT_ELF = $(BOOT_BIN_DIR)/$(BOOT_BIN_NAME).elf
# Bootloader specific linker flags
BOOT_LD_FLAGS += -Wl,-Map=$(BOOT_BIN_DIR)/$(BOOT_BIN_NAME).map,--cref -T$(COMMON_DIR)/Linker/STM32F439ZITX_bootloader.ld


VPATH := $(sort $(dir $(COMMON_ASM_SRCS) $(APP_C_SOURCES) $(BOOT_C_SOURCES)))

# Application variables
APP_HEADERS += $(COMMON_C_HEADERS)
# Add common sources to application sources
APP_C_SOURCES += $(COMMON_C_SRCS)
# Generate list of needed objects
APP_OBJS = $(addprefix $(APP_OBJ_DIR)/, $(notdir $(COMMON_ASM_SRCS:.s=.o)))
APP_OBJS += $(addprefix $(APP_OBJ_DIR)/, $(notdir $(APP_C_SOURCES:.c=.o)))
# Compiled files name
APP_BIN_NAME=$(PROJECT_NAME)_App
APP_BIN=$(APP_BIN_DIR)/$(APP_BIN_NAME).bin
APP_ELF=$(APP_BIN_DIR)/$(APP_BIN_NAME).elf

APP_LD_FLAGS = -Wl,-Map=$(APP_BIN_DIR)/$(APP_BIN_NAME).map,--cref -T$(COMMON_DIR)/Linker/STM32F439ZITX_application.ld

# Common variables
BIN_DIR=Build
BIN_NAME=$(PROJECT_NAME)
BIN=$(BIN_DIR)/$(BIN_NAME).bin


