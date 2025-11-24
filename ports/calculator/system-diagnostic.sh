#!/bin/sh
# System diagnostic for calculator compatibility

echo "=== KNULLI System Diagnostic ==="
echo ""

echo "1. Checking glibc version..."
ldd --version | head -1 || echo "ldd not available"
ls -la /lib/libc.so.* 2>/dev/null || echo "Can't find libc"
echo ""

echo "2. Checking for SDL2..."
ls -la /usr/lib/libSDL2* 2>/dev/null || ls -la /lib/libSDL2* 2>/dev/null || echo "SDL2 not found in /usr/lib or /lib"
echo ""

echo "3. Checking architecture..."
uname -m
echo ""

echo "4. Testing if calculator binary exists..."
if [ -f "./calculator/calculator" ]; then
    echo "Binary found"
    file ./calculator/calculator 2>/dev/null || echo "file command not available"
else
    echo "Binary NOT found - make sure you're in the calculator directory"
fi
echo ""

echo "5. Trying to run calculator and capture error..."
if [ -f "./calculator/calculator" ]; then
    chmod +x ./calculator/calculator
    ./calculator/calculator 2>&1 || true
fi

echo ""
echo "=== End Diagnostic ==="
echo "Please share this entire output!"
