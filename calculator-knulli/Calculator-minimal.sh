#!/bin/bash
# Minimal calculator launcher for KNULLI/EmulationStation

# Log everything
exec > /userdata/roms/ports/calculator-launch.log 2>&1

echo "=== Calculator Launch Debug ==="
echo "Time: $(date)"
echo "PWD: $(pwd)"
echo "Script: $0"
echo "User: $(whoami)"
echo ""

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Script dir: $SCRIPT_DIR"
cd "$SCRIPT_DIR" || exit 1

# Check if binary exists
if [ ! -f "calculator" ]; then
    echo "ERROR: calculator binary not found in $SCRIPT_DIR"
    ls -la
    exit 1
fi

echo "Binary found: $(ls -lh calculator)"
echo ""

# Check dependencies
echo "=== Checking dependencies ==="
if command -v ldd >/dev/null 2>&1; then
    ldd calculator
else
    echo "ldd command not found"
fi
echo ""

# Set library path
export LD_LIBRARY_PATH="/usr/lib:/lib:$LD_LIBRARY_PATH"
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
echo ""

# Check SDL
echo "=== Checking SDL2 ==="
if ldconfig -p 2>/dev/null | grep -q libSDL2; then
    echo "SDL2 found:"
    ldconfig -p | grep libSDL2
else
    echo "WARNING: SDL2 not found in ldconfig"
    find /usr/lib /lib -name "*SDL2*.so*" 2>/dev/null
fi
echo ""

# Try to run
echo "=== Attempting to launch calculator ==="
./calculator
EXIT_CODE=$?

echo ""
echo "=== Exit code: $EXIT_CODE ==="
echo "Time: $(date)"

exit $EXIT_CODE
