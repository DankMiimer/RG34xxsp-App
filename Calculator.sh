#!/bin/bash
# Calculator for KNULLI/Batocera
# Based on official Batocera ports structure

# Get the directory where this script lives
DIR="$(dirname "$(readlink -f "$0")")"

# Change to that directory
cd "${DIR}"

# Set up library paths
export LD_LIBRARY_PATH="${DIR}:${LD_LIBRARY_PATH}"

# Set up SDL for the handheld
export SDL_VIDEODRIVER=kmsdrm
export SDL_AUDIODRIVER=alsa

# Ensure binary is executable
chmod +x "${DIR}/calculator"

# Run calculator and log output
"${DIR}/calculator" 2>&1 | tee /tmp/calculator.log

# Capture exit code
EXIT_CODE=$?

# If it failed, show the log briefly
if [ $EXIT_CODE -ne 0 ]; then
    echo ""
    echo "Calculator exited with error code: $EXIT_CODE"
    echo "Check /tmp/calculator.log for details"
    sleep 3
fi

exit $EXIT_CODE
