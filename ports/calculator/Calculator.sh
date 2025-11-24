#!/bin/bash
# Calculator - PortsMaster port
# Description: Full-featured calculator with basic arithmetic operations

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt
[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"
get_controls

GAMEDIR="/$directory/ports/calculator"

export SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"
export LD_LIBRARY_PATH="$GAMEDIR/libs:$LD_LIBRARY_PATH"

cd $GAMEDIR

# Configure SDL for optimal performance
export SDL_VIDEODRIVER=kmsdrm
export SDL_AUDIODRIVER=alsa

# Run calculator
$ESUDO chmod +x "$GAMEDIR/calculator/calculator"
$ESUDO "$GAMEDIR/calculator/calculator"

pm_finish
