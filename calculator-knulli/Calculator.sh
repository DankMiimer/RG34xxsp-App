#!/bin/bash
# Calculator App for RG34xxsp (KNULLI)
# Portable launcher script

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Set up library paths
export LD_LIBRARY_PATH="/usr/lib:$LD_LIBRARY_PATH"

# Launch calculator
cd "$SCRIPT_DIR"
exec ./calculator
