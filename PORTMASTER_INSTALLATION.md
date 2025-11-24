# Calculator - PortsMaster Installation Guide

## Overview

The Calculator app is now packaged for **PortsMaster**, the standard port management system for handheld Linux devices including KNULLI Gladiator 2.

## Installation Methods

### Method 1: Via PortsMaster (Recommended)

If you have PortsMaster installed on your device:

1. Download `Calculator-PortsMaster.zip`
2. Copy it to your device's ports directory: `/roms/ports/`
3. Extract the zip file: `unzip Calculator-PortsMaster.zip`
4. Launch PortsMaster from your Ports menu
5. The Calculator should appear in your available ports
6. Select it to install/launch

### Method 2: Manual Installation

1. Download `Calculator-PortsMaster.zip`
2. Extract the entire `calculator` folder to `/roms/ports/` on your device
3. Ensure the launcher script is executable:
   ```bash
   chmod +x /roms/ports/calculator/Calculator.sh
   chmod +x /roms/ports/calculator/calculator/calculator
   ```
4. Restart EmulationStation
5. Navigate to the Ports section and launch "Calculator"

### Method 3: SSH Transfer

```bash
# Copy the package to your device
scp Calculator-PortsMaster.zip root@<device-ip>:/tmp/

# SSH into the device
ssh root@<device-ip>

# Extract to ports directory
cd /roms/ports/
unzip /tmp/Calculator-PortsMaster.zip

# Set permissions
chmod +x calculator/Calculator.sh
chmod +x calculator/calculator/calculator

# Clean up
rm /tmp/Calculator-PortsMaster.zip
```

## Package Contents

```
calculator/
├── port.json              # PortsMaster metadata
├── README.md              # Detailed documentation
├── gameinfo.xml           # EmulationStation integration
├── Calculator.sh          # PortsMaster-compatible launcher
├── SCREENSHOT_NEEDED.txt  # Note about adding screenshot
└── calculator/
    ├── calculator         # ARM64 binary
    └── licenses/
        └── LICENSE        # Software licenses
```

## Features

- ✓ PortsMaster compatible packaging
- ✓ Automatic control mapping via PortsMaster
- ✓ EmulationStation integration with metadata
- ✓ Clean installation and uninstallation
- ✓ Optimized for ARM64/AARCH64 architecture
- ✓ Works with KNULLI Gladiator 2 and other CFW

## Controls

- **D-Pad**: Navigate between calculator buttons
- **A Button**: Press the selected button
- **B/Start/Select**: Exit calculator

## Architecture

- **Target**: ARM64/AARCH64 (RG34xxsp, RG40XXV, etc.)
- **Requirements**: SDL2 and SDL2_ttf (included in KNULLI)
- **Display**: Optimized for 720x480 resolution
- **Memory**: Minimal footprint (~71KB binary)

## Adding a Screenshot (Optional)

For a complete PortsMaster submission:

1. Run the calculator on your device
2. Take a screenshot (min. 640x480 resolution)
3. Save as `ports/calculator/screenshot.png`
4. Delete `SCREENSHOT_NEEDED.txt`

## Troubleshooting

**Calculator doesn't appear in Ports menu:**
- Ensure the folder is in `/roms/ports/calculator/`
- Check that `Calculator.sh` is executable
- Restart EmulationStation

**Permissions error:**
- Run: `chmod +x /roms/ports/calculator/Calculator.sh`
- Run: `chmod +x /roms/ports/calculator/calculator/calculator`

**SDL error on launch:**
- KNULLI includes SDL2 by default
- Try running from terminal to see error messages:
  ```bash
  /roms/ports/calculator/Calculator.sh
  ```

## Contributing to PortsMaster

To submit this port to the official PortsMaster repository:

1. Fork https://github.com/PortsMaster/PortMaster-New
2. Add the `calculator` folder to the `ports/` directory
3. Add a proper screenshot.png (640x480 minimum)
4. Run validation: `python3 tools/build_release.py --do-check`
5. Create a pull request

## Support

For issues specific to:
- **Calculator app**: Open an issue in this repository
- **PortsMaster**: Visit https://portmaster.games/
- **KNULLI**: Visit https://knulli.org/ or Discord

---

Enjoy calculating on your handheld! 🧮
