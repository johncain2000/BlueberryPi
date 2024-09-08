# Compiler and flags
CC = avr-gcc
CFLAGS = -mmcu=attiny85 -DF_CPU=1000000UL -Os -Wall -Wextra -std=c99

# Directories
SRC_DIR = src
BUILD_DIR = build

# Source files
MAIN_SRC = main.c
SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
SRCS = $(MAIN_SRC) $(SRC_FILES)
OBJS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(notdir $(SRCS)))

# Include directories
INCLUDES = -I$(SRC_DIR)

# Target
TARGET = main

all: $(BUILD_DIR)/$(TARGET).hex

$(BUILD_DIR)/$(TARGET).hex: $(BUILD_DIR)/$(TARGET).elf
	avr-objcopy -O ihex $< $@
	avr-objdump -h -S $< > $(BUILD_DIR)/$(TARGET).lst
	avr-size $

$(BUILD_DIR)/$(TARGET).elf: $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

clean:
	@echo "Cleaning files"
	rm -rf $(BUILD_DIR)

hello:
	@echo "world"

.PHONY: all clean hello