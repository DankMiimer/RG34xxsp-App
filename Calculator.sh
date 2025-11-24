#!/bin/sh
# Calculator for KNULLI - Direct EmulationStation launcher

PORTDIR="/userdata/roms/ports"

cd "$PORTDIR"

# Set up SDL
export SDL_VIDEODRIVER=kmsdrm
export SDL_AUDIODRIVER=alsa
export LD_LIBRARY_PATH="$PORTDIR:$LD_LIBRARY_PATH"

# Make sure binary is executable
chmod +x "$PORTDIR/calculator"

# Run calculator with error output
echo "Starting calculator..." > /tmp/calculator.log
"$PORTDIR/calculator" >> /tmp/calculator.log 2>&1

# Show exit code
EXIT_CODE=$?
echo "Exit code: $EXIT_CODE" >> /tmp/calculator.log

if [ $EXIT_CODE -ne 0 ]; then
    echo "Calculator failed. Check /tmp/calculator.log"
    sleep 3
fi
