#!/bin/bash
# Calculator App for RG34xxsp (KNULLI)
# Launch script for ports folder structure

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Binary is in Calculator subdirectory
CALC_DIR="$SCRIPT_DIR/Calculator"

# Set up library paths
export LD_LIBRARY_PATH="/usr/lib:$LD_LIBRARY_PATH"

# Launch calculator
cd "$CALC_DIR"
exec ./calculator 2>&1 | tee calculator.log
