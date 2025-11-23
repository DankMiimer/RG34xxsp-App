#!/bin/bash
# Build script for Calculator App - RG34xxsp
# Cross-compilation for ARM64/AARCH64 architecture

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
TARGET="calculator"
BUILD_DIR="build"
SDL2_DIR="SDL2"

echo -e "${GREEN}Calculator App - Build Script${NC}"
echo "=============================="
echo ""

# Check for cross-compiler
if ! command -v aarch64-linux-gnu-gcc &> /dev/null; then
    echo -e "${RED}Error: aarch64-linux-gnu-gcc not found!${NC}"
    echo ""
    echo "Please install the ARM64 cross-compiler:"
    echo "  sudo apt update"
    echo "  sudo apt install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu"
    echo ""
    exit 1
fi

echo -e "${GREEN}✓${NC} ARM64 cross-compiler found"

# Check for SDL2 libraries
if [ ! -d "$SDL2_DIR/lib" ] || [ ! -d "$SDL2_DIR/include" ]; then
    echo -e "${YELLOW}Warning: SDL2 libraries not found in $SDL2_DIR/${NC}"
    echo ""
    echo "You need SDL2 and SDL2_ttf libraries for ARM64."
    echo ""
    echo "Option 1: Download precompiled libraries from archlinuxarm.org"
    echo "  - SDL2: https://archlinuxarm.org/packages/aarch64/sdl2"
    echo "  - SDL2_ttf: https://archlinuxarm.org/packages/aarch64/sdl2_ttf"
    echo ""
    echo "Option 2: Cross-compile SDL2 from source"
    echo ""
    echo "Extract libraries to:"
    echo "  $SDL2_DIR/lib/     (libSDL2.so, libSDL2_ttf.so)"
    echo "  $SDL2_DIR/include/ (SDL2/*.h)"
    echo ""

    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create build directory
mkdir -p "$BUILD_DIR"

# Build using make
echo ""
echo -e "${GREEN}Building calculator...${NC}"
make all

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✓ Build successful!${NC}"
    echo ""
    echo "Output files:"
    echo "  $BUILD_DIR/$TARGET"
    echo "  $BUILD_DIR/$TARGET.sh"
    echo ""
    echo -e "${GREEN}Installation Instructions:${NC}"
    echo "=========================="
    echo ""
    echo "1. Copy files to your RG34xxsp:"
    echo "   Via SSH:"
    echo "     scp $BUILD_DIR/* root@<device-ip>:/mnt/sdcard/Roms/APPS/Calculator/"
    echo ""
    echo "   Or copy to SD card:"
    echo "     - Remove SD card from device"
    echo "     - Mount on computer"
    echo "     - Copy to: /Roms/APPS/Calculator/"
    echo ""
    echo "2. Launch from APPS menu on device"
    echo ""
    echo -e "${GREEN}Controls:${NC}"
    echo "  D-Pad: Navigate buttons"
    echo "  A button: Press selected button"
    echo "  Number keys: Direct input (when testing on PC)"
    echo "  ESC/Menu: Exit calculator"
    echo ""
else
    echo ""
    echo -e "${RED}✗ Build failed!${NC}"
    echo ""
    exit 1
fi
