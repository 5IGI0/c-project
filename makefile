TARGET_EXEC = a.out
BUILD_DIR = ./build/$(shell $(CC) -dumpmachine)
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
	$(RM) -r $(BUILD_DIR)

MKDIR_P ?= mkdir -p