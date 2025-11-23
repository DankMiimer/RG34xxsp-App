#!/bin/sh
# Calculator launcher for KNULLI
cd "$(dirname "$0")"
export LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH"
export SDL_VIDEODRIVER=kmsdrm
export SDL_AUDIODRIVER=alsa
./calculator
