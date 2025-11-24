#!/bin/bash
# Calculator - Standalone (No PortMaster Required)
# Works on KNULLI/Batocera without PortMaster installed

# Get directory of this script
DIR="$(dirname "$(readlink -f "$0")")"
cd "${DIR}"

# Set up library paths
export LD_LIBRARY_PATH="${DIR}:${LD_LIBRARY_PATH}"

# Configure SDL for KNULLI/Batocera
export SDL_VIDEODRIVER=kmsdrm
export SDL_AUDIODRIVER=alsa

# Make binary executable
chmod +x "${DIR}/calculator"

# Run with full logging
echo "=== Calculator Launch ===" > /tmp/calculator.log
echo "Date: $(date)" >> /tmp/calculator.log
echo "Directory: ${DIR}" >> /tmp/calculator.log
echo "" >> /tmp/calculator.log

"${DIR}/calculator" 2>&1 | tee -a /tmp/calculator.log

EXIT_CODE=$?
echo "" >> /tmp/calculator.log
echo "Exit code: $EXIT_CODE" >> /tmp/calculator.log

if [ $EXIT_CODE -ne 0 ]; then
    echo "Calculator failed - check /tmp/calculator.log"
    sleep 2
fi

exit $EXIT_CODE
