TARGET_EXEC := webserver

BUILD_DIR := ./build
SRC_DIR := ./src
INC_DIRS := ./include

CC := clang
CFLAGS := $(addprefix -I, $(INC_DIRS)) -MMD -MP

SRCS := $(shell find $(SRC_DIR) -name '*.c')
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@

$(BUILD_DIR)/$(SRC_DIR)/%.c.o: $(SRC_DIR)/%.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean test

test: $(BUILD_DIR)/$(TARGET_EXEC)
	./$<

clean:
	rm -rf $(BUILD_DIR)

-include $(DEPS)
