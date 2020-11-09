TARGET_EXEC = ../$(shell $(CC) -dumpmachine).bin
BUILDS_DIR = ./build
BUILD_DIR = $(BUILDS_DIR)/build-$(shell $(CC) -dumpmachine)
SRC_DIRS = ./src

SRCS = $(shell find $(SRC_DIRS) -name *.c -or -name *.s)
OBJS = $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS = $(OBJS:.o=.d)

CFLAGS ?= -Wall -Wextra

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)
$(BUILD_DIR)/%.s.o: %.s
	$(MKDIR_P) $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@
$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	$(RM) -r $(BUILDS_DIR)/build-*/ $(BUILDS_DIR)/*.bin

MKDIR_P ?= mkdir -p