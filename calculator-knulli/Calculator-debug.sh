#!/bin/sh
# Calculator DEBUG launcher for KNULLI
# This version logs all output to help diagnose issues

LOGFILE="/tmp/calculator-debug.log"

echo "=== Calculator Debug Log ===" > "$LOGFILE"
echo "Date: $(date)" >> "$LOGFILE"
echo "Working directory: $(pwd)" >> "$LOGFILE"
echo "" >> "$LOGFILE"

cd "$(dirname "$0")"

# Log environment
echo "=== Environment ===" >> "$LOGFILE"
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH" >> "$LOGFILE"
echo "SDL_VIDEODRIVER: $SDL_VIDEODRIVER" >> "$LOGFILE"
echo "SDL_AUDIODRIVER: $SDL_AUDIODRIVER" >> "$LOGFILE"
echo "" >> "$LOGFILE"

# Check for calculator binary
echo "=== File Check ===" >> "$LOGFILE"
ls -lh calculator >> "$LOGFILE" 2>&1

# Check for fonts
echo "" >> "$LOGFILE"
echo "=== Font Check ===" >> "$LOGFILE"
ls -lh /usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf >> "$LOGFILE" 2>&1
ls -lh /usr/share/fonts/TTF/DejaVuSans-Bold.ttf >> "$LOGFILE" 2>&1
ls -lh ./font.ttf >> "$LOGFILE" 2>&1
ls -lh /usr/share/fonts/ >> "$LOGFILE" 2>&1

# Check for SDL libraries
echo "" >> "$LOGFILE"
echo "=== SDL Libraries ===" >> "$LOGFILE"
ldconfig -p | grep SDL2 >> "$LOGFILE" 2>&1

export LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH"
export SDL_VIDEODRIVER=kmsdrm
export SDL_AUDIODRIVER=alsa

# Run calculator with full error logging
echo "" >> "$LOGFILE"
echo "=== Calculator Output ===" >> "$LOGFILE"
./calculator >> "$LOGFILE" 2>&1
EXIT_CODE=$?

echo "" >> "$LOGFILE"
echo "=== Exit Code: $EXIT_CODE ===" >> "$LOGFILE"

# Show log on screen if it failed
if [ $EXIT_CODE -ne 0 ]; then
    echo "Calculator failed! Check log at: $LOGFILE"
    sleep 3
fi
