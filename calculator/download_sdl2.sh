#!/bin/bash
# Download SDL2 libraries for ARM64/AARCH64

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDL2_DIR="$SCRIPT_DIR/SDL2"

echo "Downloading SDL2 libraries for ARM64..."
echo ""

# Create directories
mkdir -p "$SDL2_DIR/lib"
mkdir -p "$SDL2_DIR/include/SDL2"

cd /tmp

# Download SDL2 headers
if [ ! -f "$SDL2_DIR/include/SDL2/SDL.h" ]; then
    echo "Downloading SDL2 headers..."
    wget -q https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.28.5.tar.gz -O sdl2-src.tar.gz
    tar -xzf sdl2-src.tar.gz
    cp -r SDL-release-2.28.5/include/* "$SDL2_DIR/include/SDL2/"
    rm -rf SDL-release-2.28.5 sdl2-src.tar.gz
    echo "✓ SDL2 headers downloaded"
fi

# Download SDL2_ttf headers
if [ ! -f "$SDL2_DIR/include/SDL2/SDL_ttf.h" ]; then
    echo "Downloading SDL2_ttf headers..."
    wget -q https://github.com/libsdl-org/SDL_ttf/archive/refs/tags/release-2.20.2.tar.gz -O sdl2-ttf-src.tar.gz
    tar -xzf sdl2-ttf-src.tar.gz
    cp SDL_ttf-release-2.20.2/SDL_ttf.h "$SDL2_DIR/include/SDL2/"
    rm -rf SDL_ttf-release-2.20.2 sdl2-ttf-src.tar.gz
    echo "✓ SDL2_ttf headers downloaded"
fi

echo ""
echo "Headers installed to: $SDL2_DIR/include/"
echo ""
echo "Note: ARM64 SDL2 libraries (.so files) are typically already"
echo "      present on the RG34xxsp device at /usr/lib/"
echo ""
echo "The build will link against system libraries on the device."
echo ""
