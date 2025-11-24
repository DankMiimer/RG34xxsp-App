#!/bin/bash
# Calculator - PortMaster Compatible Port
# Based on PortMaster packaging guide: https://portmaster.games/packaging.html

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

# Detect PortMaster control folder across different CFWs
if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

# Source control.txt to get device-specific variables
source $controlfolder/control.txt
# Source CFW-specific modifications if they exist
[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"
# Get controller configuration
get_controls

# Set up game directory
GAMEDIR="/$directory/ports"

# Export controller configuration for SDL
export SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"

# Set up library path for device architecture
export LD_LIBRARY_PATH="$GAMEDIR:$GAMEDIR/libs:$LD_LIBRARY_PATH"

# Configure SDL for the device
export SDL_VIDEODRIVER=kmsdrm
export SDL_AUDIODRIVER=alsa

# Change to game directory
cd $GAMEDIR

# Ensure binary is executable
$ESUDO chmod +x "$GAMEDIR/calculator"

# Run calculator with logging
$ESUDO "$GAMEDIR/calculator" 2>&1 | tee /tmp/calculator.log

# Cleanup and return to EmulationStation
pm_finish
