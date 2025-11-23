Calculator App for RG34xxsp (KNULLI Firmware)
===============================================

Installation Instructions for KNULLI:

METHOD 1: Via Network/SSH (Recommended)
----------------------------------------
1. Enable SSH in KNULLI settings
2. Find your device's IP address (System Settings > Network)
3. Copy files to device:

   scp Calculator.sh calculator root@<device-ip>:/userdata/roms/ports/

4. SSH into device and set permissions:

   ssh root@<device-ip>
   chmod +x /userdata/roms/ports/Calculator.sh
   chmod +x /userdata/roms/ports/calculator

5. Restart EmulationStation or reboot device


METHOD 2: Via SD Card
---------------------
1. Power off your RG34xxsp
2. Remove the SD card
3. Insert SD card into your computer
4. Navigate to: SHARE/roms/ports/ (or userdata/roms/ports/)
5. Copy these files:
   - Calculator.sh
   - calculator

6. Safely eject the SD card
7. Insert back into RG34xxsp and power on
8. The Calculator should appear in the "Ports" section


METHOD 3: File Manager on Device
---------------------------------
1. Copy Calculator.sh and calculator to a USB drive
2. Insert USB into RG34xxsp
3. Use the built-in file manager to copy files to:
   /userdata/roms/ports/
4. Set executable permissions via file manager or terminal


Launching the Calculator:
-------------------------
1. From EmulationStation main menu
2. Navigate to "Ports" section
3. Select "Calculator"
4. The app will launch in fullscreen


Controls:
---------
D-Pad: Navigate between calculator buttons
A Button: Press the selected button
B Button / Start / Select: Exit calculator


Features:
---------
✓ Basic arithmetic operations (+, -, *, /)
✓ Decimal point support
✓ Clear (C) and All Clear (AC)
✓ Delete last digit (DEL)
✓ 16-digit precision display
✓ Error handling (division by zero, overflow)
✓ Color-coded buttons


Troubleshooting:
----------------
If calculator doesn't appear in Ports:
- Make sure Calculator.sh is executable
- Restart EmulationStation (Start > Quit > Restart ES)
- Check that files are in /userdata/roms/ports/
- Verify file permissions (chmod +x)

If calculator doesn't launch:
- Check that SDL2 is installed (should be by default on KNULLI)
- Try launching from terminal: /userdata/roms/ports/Calculator.sh
- Check for error messages in logs

For font issues:
- KNULLI includes DejaVu fonts by default
- Calculator will try multiple font paths automatically


Support:
--------
For issues specific to KNULLI, check:
- KNULLI Discord: https://discord.gg/HXPS3DAeeB
- KNULLI Wiki: https://knulli.org/

Enjoy your calculator! 🧮
