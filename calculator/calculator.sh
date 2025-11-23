#!/bin/sh
# Launch script for Calculator App on RG34xxsp
# This script sets up the environment and launches the calculator

# Change to the directory where the script is located
cd "$(dirname "$0")"

# Set library path to include current directory for SDL2 libraries
export LD_LIBRARY_PATH=".:${LD_LIBRARY_PATH}"

# Launch the calculator
./calculator

# Exit code
exit $?
