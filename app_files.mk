APP_DIR = Application
APP_SRC_DIR = $(APP_DIR)/Src
APP_BIN_DIR = $(APP_DIR)/Build
APP_OBJ_DIR = $(APP_BIN_DIR)/obj

APP_HEADERS =
APP_HEADERS += -ICommon/Linker/

APP_C_SOURCES =
APP_C_SOURCES += $(APP_SRC_DIR)/main.c

APP_C_FLAGS = -DVECT_TAB_OFFSET=0x08020000