#!/bin/bash
# Ultra-simple test script to verify basic execution

# Write to a file to prove script ran
echo "Script started at $(date)" > /userdata/roms/ports/test-output.txt
echo "Current directory: $(pwd)" >> /userdata/roms/ports/test-output.txt
echo "User: $(whoami)" >> /userdata/roms/ports/test-output.txt
echo "Environment:" >> /userdata/roms/ports/test-output.txt
env >> /userdata/roms/ports/test-output.txt

# Try to show a simple dialog or wait
sleep 5

echo "Script ended at $(date)" >> /userdata/roms/ports/test-output.txt
