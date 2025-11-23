# Makefile for Calculator App - RG34xxsp
# Cross-compilation for ARM64/AARCH64 architecture

# Toolchain configuration
CC = aarch64-linux-gnu-gcc
CXX = aarch64-linux-gnu-g++

# Target executable name
TARGET = calculator

# Directories
SRC_DIR = src
BUILD_DIR = build
SDL2_DIR = SDL2

# Source files
SOURCES = $(SRC_DIR)/calculator.c

# Compiler flags
CFLAGS = -std=c99 -O2 -Wall -Wextra
CFLAGS += -DHANDHELD

# Include paths
INCLUDES = -I$(SDL2_DIR)/include
INCLUDES += -I/usr/aarch64-linux-gnu/include

# Library paths (dynamic linking - libraries must be on device)
LDFLAGS = -L$(SDL2_DIR)/lib -L/usr/aarch64-linux-gnu/lib
LDFLAGS += -Wl,--allow-shlib-undefined -Wl,--unresolved-symbols=ignore-all

# Libraries to link (will be resolved at runtime on device)
LIBS = -lSDL2 -lSDL2_ttf -lfreetype -lpthread -lm -ldl

# Build targets
.PHONY: all clean install

all: $(BUILD_DIR)/$(TARGET) $(BUILD_DIR)/$(TARGET).sh

$(BUILD_DIR)/$(TARGET): $(SOURCES)
	@mkdir -p $(BUILD_DIR)
	@echo "Cross-compiling for ARM64/AARCH64..."
	$(CC) $(CFLAGS) $(INCLUDES) $(SOURCES) -o $@ $(LDFLAGS) $(LIBS)
	@echo "Build complete: $@"

$(BUILD_DIR)/$(TARGET).sh: $(BUILD_DIR)/$(TARGET)
	@echo "Creating launch script..."
	@echo '#!/bin/sh' > $@
	@echo 'cd "$$(dirname "$$0")"' >> $@
	@echo 'export LD_LIBRARY_PATH=".:$$LD_LIBRARY_PATH"' >> $@
	@echo './$(TARGET)' >> $@
	@chmod +x $@
	@echo "Launch script created: $@"

clean:
	@echo "Cleaning build files..."
	@rm -rf $(BUILD_DIR)/*
	@echo "Clean complete"

install: all
	@echo "Build complete! To install on device:"
	@echo "1. Copy the contents of $(BUILD_DIR)/ to your device:"
	@echo "   scp $(BUILD_DIR)/* root@<device-ip>:/mnt/sdcard/Roms/APPS/Calculator/"
	@echo "2. Or copy to SD card: /Roms/APPS/Calculator/"
	@echo "3. Launch from APPS menu on device"

# Help target
help:
	@echo "Calculator App - Build Instructions"
	@echo "===================================="
	@echo ""
	@echo "Targets:"
	@echo "  make all      - Build the calculator app (default)"
	@echo "  make clean    - Remove build files"
	@echo "  make install  - Show installation instructions"
	@echo "  make help     - Show this help message"
	@echo ""
	@echo "Requirements:"
	@echo "  - aarch64-linux-gnu-gcc cross-compiler"
	@echo "  - SDL2 and SDL2_ttf libraries for ARM64"
	@echo ""
	@echo "To install cross-compiler:"
	@echo "  sudo apt install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu"
