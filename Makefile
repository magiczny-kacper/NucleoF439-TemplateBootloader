
PROJECT_NAME=NucleoF439_Template

# Toolchain variables
TOOLCHAIN := arm-none-eabi-

CC = $(TOOLCHAIN)gcc
CXX = $(TOOLCHAIN)g++
AS = $(TOOLCHAIN)gcc -x assembler-with-cpp
OBJCOPY = $(TOOLCHAIN)objcopy
OBJDUMP = $(TOOLCHAIN)objdump
SIZE = $(TOOLCHAIN)size

include files.mk

CORE_FLAGS = -mcpu=cortex-m4
CORE_FLAGS += -mthumb
CORE_FLAGS += -g
CORE_FLAGS += -mfloat-abi=soft
CORE_FLAGS += -mfpu=fpv4-sp-d16
CORE_FLAGS += -ffast-math
CORE_FLAGS += -DSTM32F439xx
CORE_FLAGS += -MMD

GLOBAL_C_FLAGS = $(CORE_FLAGS)
GLOBAL_C_FLAGS += -std=gnu11
GLOBAL_C_FLAGS += -O0
GLOBAL_C_FLAGS += -ffunction-sections
GLOBAL_C_FLAGS += -fdata-sections
GLOBAL_C_FLAGS += -fverbose-asm
GLOBAL_C_FLAGS += -Wall
GLOBAL_C_FLAGS += -Wextra
GLOBAL_C_FLAGS += -Wstrict-prototypes
GLOBAL_C_FLAGS += -specs=nano.specs -specs=nosys.specs

GLOBAL_LD_FLAGS = -g
GLOBAL_LD_FLAGS += -Wl,--gc-sections
GLOBAL_LD_FLAGS += -Wl,--print-memory-usage
GLOBAL_LD_FLAGS += -specs=nano.specs -specs=nosys.specs

$(info Bootloader objects: $(BOOT_OBJS))
$(info Bootloader obj dir: $(BOOT_OBJ_DIR))
$(info Application objects: $(APP_OBJS))
$(info Application obj dir: $(APP_OBJ_DIR))
# Rules
all: clean out_dir bin

bin: out_dir $(BIN)

app: out_dir $(APP_BIN)

boot: out_dir $(BOOT_BIN)

# Whole binary file
$(BIN): $(BOOT_BIN) $(APP_BIN)
	cat $^ > $@
	$(OBJCOPY) --input-target=binary --output-target=elf32-little $@

$(APP_BIN): $(APP_ELF)
	$(OBJCOPY) $< $@ -O binary
	$(SIZE) $<

$(BOOT_BIN): $(BOOT_ELF)
	$(info Creating $@)
	$(OBJCOPY) -j BOOT_FLASH --pad-to=0x20000 --gap-fill=0xFF -O binary $< $@
	$(SIZE) $<

$(APP_ELF): $(APP_OBJS)
	$(info APP: Creating $@)
	$(CC) $(APP_LD_FLAGS) $(GLOBAL_LD_FLAGS) $(APP_OBJS) -o $@

$(BOOT_ELF): $(BOOT_OBJS)
	$(info BOOT: Creating $@)
	$(CC) $(BOOT_LD_FLAGS) $(GLOBAL_LD_FLAGS) $(BOOT_OBJS) -o $@

# Application objects rules
$(APP_OBJ_DIR)/%.o: $(APP_SRC_DIR)/%.c
	$(info APP: processing $< to $@)
	$(CC) $(GLOBAL_C_FLAGS) $(APP_C_FLAGS) $(APP_HEADERS) -c $< -o $@

$(APP_OBJ_DIR)/%.o: $(COMMON_C_DIR)/%.c
	$(info APP: processing $< to $@)
	$(CC) $(GLOBAL_C_FLAGS) $(APP_C_FLAGS) $(APP_HEADERS) -c $< -o $@

$(APP_OBJ_DIR)/%.o: $(APP_SRC_DIR)/%.s
	$(info APP: processing $< to $@)
	$(CC) $(GLOBAL_C_FLAGS) $(APP_HEADERS) -c $< -o $@

# Bootloader objects rules
$(BOOT_OBJ_DIR)/%.o: $(BOOT_SRC_DIR)/%.c
	$(info BOOT: processing $< to $@)
	$(CC) $(GLOBAL_C_FLAGS) $(BOOT_C_FLAGS) $(BOOT_HEADERS) -c $< -o $@

$(BOOT_OBJ_DIR)/%.o: $(COMMON_C_DIR)/%.c
	$(info BOOT: processing $< to $@)
	$(CC) $(GLOBAL_C_FLAGS) $(BOOT_C_FLAGS) $(BOOT_HEADERS) -c $< -o $@

$(BOOT_OBJ_DIR)/%.o: $(BOOT_SRC_DIR)/%.s
	$(info BOOT: processing $< to $@)
	$(CC) $(GLOBAL_C_FLAGS) $(BOOT_HEADERS) -c $< -o $@

.PHONY: out_dir
out_dir: $(BOOT_BIN_DIR) $(BOOT_OBJ_DIR) $(APP_BIN_DIR) $(APP_OBJ_DIR) $(BIN_DIR)

$(BOOT_BIN_DIR):
	mkdir $(BOOT_BIN_DIR)

$(APP_BIN_DIR):
	mkdir $(APP_BIN_DIR)

$(BIN_DIR):
	mkdir $(BIN_DIR)

$(APP_OBJ_DIR): $(APP_BIN_DIR)
	mkdir $(APP_OBJ_DIR)

$(BOOT_OBJ_DIR): $(BOOT_BIN_DIR)
	mkdir $(BOOT_OBJ_DIR)

clean:
	rm -rf $(BOOT_BIN_DIR)/*
	rm -rf $(APP_BIN_DIR)/*
	rm -rf $(BIN_DIR)/*
