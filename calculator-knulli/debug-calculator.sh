#!/bin/bash
# Debug script for Calculator on KNULLI

echo "=========================================="
echo "Calculator Debug Information"
echo "=========================================="
echo ""

# Check if calculator binary exists
if [ -f "./calculator" ]; then
    echo "✓ calculator binary found"
    ls -lh calculator
else
    echo "✗ calculator binary NOT found"
    exit 1
fi

echo ""
echo "Checking for required libraries..."
echo "-----------------------------------"

# Check for SDL2
if ldconfig -p | grep -q libSDL2; then
    echo "✓ SDL2 library found:"
    ldconfig -p | grep libSDL2
else
    echo "✗ SDL2 library NOT found"
fi

# Check for SDL2_ttf
if ldconfig -p | grep -q libSDL2_ttf; then
    echo "✓ SDL2_ttf library found:"
    ldconfig -p | grep libSDL2_ttf
else
    echo "✗ SDL2_ttf library NOT found"
fi

# Check for freetype
if ldconfig -p | grep -q libfreetype; then
    echo "✓ freetype library found:"
    ldconfig -p | grep libfreetype
else
    echo "✗ freetype library NOT found"
fi

echo ""
echo "Checking for fonts..."
echo "-----------------------------------"

# Check common font paths
FONT_PATHS=(
    "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"
    "/usr/share/fonts/TTF/DejaVuSans-Bold.ttf"
    "/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf"
    "/storage/roms/fonts/DejaVuSans-Bold.ttf"
    "/userdata/system/fonts/DejaVuSans-Bold.ttf"
)

FONT_FOUND=0
for font in "${FONT_PATHS[@]}"; do
    if [ -f "$font" ]; then
        echo "✓ Font found: $font"
        FONT_FOUND=1
    fi
done

if [ $FONT_FOUND -eq 0 ]; then
    echo "✗ No fonts found in standard locations"
    echo ""
    echo "Searching for any TTF fonts..."
    find /usr/share/fonts /storage /userdata -name "*.ttf" 2>/dev/null | head -10
fi

echo ""
echo "Attempting to run calculator..."
echo "-----------------------------------"
export LD_LIBRARY_PATH="/usr/lib:/lib:$LD_LIBRARY_PATH"
export SDL_VIDEODRIVER=kmsdrm

# Run with error output
./calculator 2>&1
EXIT_CODE=$?

echo ""
echo "Exit code: $EXIT_CODE"
echo ""

if [ $EXIT_CODE -ne 0 ]; then
    echo "Calculator failed to run!"
    echo ""
    echo "Checking dependencies with ldd..."
    ldd ./calculator
fi

echo ""
echo "=========================================="
