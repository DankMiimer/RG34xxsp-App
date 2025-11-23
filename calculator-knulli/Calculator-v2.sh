#!/bin/bash
# Calculator App for RG34xxsp (KNULLI) - Enhanced launcher with logging

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/calculator.log"

# Create log file
echo "========================================" > "$LOG_FILE"
echo "Calculator Launch Log" >> "$LOG_FILE"
echo "Time: $(date)" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Set up library paths
export LD_LIBRARY_PATH="/usr/lib:/lib:/usr/lib64:/lib64:$LD_LIBRARY_PATH"
export SDL_VIDEODRIVER=kmsdrm

# Log system info
echo "System Information:" >> "$LOG_FILE"
uname -a >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Check for SDL2
echo "Checking SDL2 libraries..." >> "$LOG_FILE"
ldconfig -p 2>&1 | grep -i sdl >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Check for fonts
echo "Checking for fonts..." >> "$LOG_FILE"
for font_path in \
    "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf" \
    "/usr/share/fonts/TTF/DejaVuSans-Bold.ttf" \
    "/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf" \
    "/storage/.config/fonts/DejaVuSans-Bold.ttf" \
    "/userdata/system/fonts/DejaVuSans-Bold.ttf"
do
    if [ -f "$font_path" ]; then
        echo "✓ Found: $font_path" >> "$LOG_FILE"
    else
        echo "✗ Missing: $font_path" >> "$LOG_FILE"
    fi
done
echo "" >> "$LOG_FILE"

# Launch calculator with error capture
echo "Launching calculator..." >> "$LOG_FILE"
cd "$SCRIPT_DIR"
./calculator >> "$LOG_FILE" 2>&1
EXIT_CODE=$?

echo "" >> "$LOG_FILE"
echo "Exit code: $EXIT_CODE" >> "$LOG_FILE"

if [ $EXIT_CODE -ne 0 ]; then
    echo "" >> "$LOG_FILE"
    echo "Calculator failed! Checking dependencies..." >> "$LOG_FILE"
    ldd ./calculator >> "$LOG_FILE" 2>&1
fi

echo "========================================" >> "$LOG_FILE"
echo "End of log" >> "$LOG_FILE"

# If calculator failed, show a simple error screen
if [ $EXIT_CODE -ne 0 ]; then
    # Try to display error using SDL or basic tools
    if command -v zenity &> /dev/null; then
        zenity --error --text="Calculator failed to start.\nCheck $LOG_FILE for details."
    elif command -v dialog &> /dev/null; then
        dialog --msgbox "Calculator failed to start.\nCheck $LOG_FILE for details." 10 50
    else
        # Just write to stderr
        echo "Calculator failed to start. Check $LOG_FILE for details." >&2
    fi
fi

exit $EXIT_CODE
