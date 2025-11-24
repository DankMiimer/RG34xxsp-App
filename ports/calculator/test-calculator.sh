#!/bin/sh
# Minimal diagnostic script for calculator

echo "=== Calculator Diagnostic ==="
echo "Current directory: $(pwd)"
echo ""

# Check if binary exists
echo "1. Checking binary..."
if [ -f "./calculator/calculator" ]; then
    echo "   ✓ Binary found"
    ls -lh ./calculator/calculator
    file ./calculator/calculator 2>/dev/null || echo "   file command not available"
else
    echo "   ✗ Binary NOT found at ./calculator/calculator"
    ls -la
    exit 1
fi

echo ""
echo "2. Checking permissions..."
if [ -x "./calculator/calculator" ]; then
    echo "   ✓ Binary is executable"
else
    echo "   ✗ Binary is NOT executable, fixing..."
    chmod +x ./calculator/calculator
fi

echo ""
echo "3. Checking for SDL2..."
if command -v ldconfig >/dev/null 2>&1; then
    ldconfig -p | grep -i sdl2 | head -3
else
    ls -la /usr/lib/*SDL2* 2>/dev/null | head -3
    ls -la /lib/*SDL2* 2>/dev/null | head -3
fi

echo ""
echo "4. Checking dependencies..."
if command -v ldd >/dev/null 2>&1; then
    ldd ./calculator/calculator 2>&1 | head -10
else
    echo "   ldd not available"
fi

echo ""
echo "5. Attempting to run calculator..."
export LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH"
./calculator/calculator 2>&1
EXIT=$?

echo ""
echo "Exit code: $EXIT"

if [ $EXIT -ne 0 ]; then
    echo ""
    echo "=== FAILURE ==="
    echo "Calculator did not run successfully."
    echo "Please share this entire output for debugging."
fi
