#!/bin/sh
# Calculator - Standalone launcher (no PortMaster required)

cd "$(dirname "$0")"

# Set up SDL
export SDL_VIDEODRIVER=kmsdrm
export SDL_AUDIODRIVER=alsa
export LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH"

# Make sure binary is executable
chmod +x calculator/calculator

# Run calculator with error output
echo "Starting calculator..."
./calculator/calculator 2>&1

# Show exit code
EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
    echo ""
    echo "Calculator exited with code: $EXIT_CODE"
    echo "Press any key to continue..."
    read -n 1
fi
