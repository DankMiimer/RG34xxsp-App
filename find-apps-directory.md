# Finding the Apps Directory on RG34xxsp

## Common Locations by Firmware:

### Stock ANBERNIC OS:
- `/mnt/sdcard/Roms/APPS/`
- `/mnt/mmc/Roms/APPS/`
- `/media/Roms/APPS/`
- `/mnt/SDCARD/Roms/APPS/` (case sensitive)

### ROCKNIX:
- `/storage/roms/ports/`
- Apps are typically installed as "ports"

### KNULLI:
- `/userdata/roms/ports/`
- Uses EmulationStation ports system

### MinUI:
- `/mnt/SDCARD/Tools/`
- Or custom apps in specific MinUI directories

## How to Find Your Directory:

### Method 1: SSH into Device
```bash
# Connect to device
ssh root@<device-ip>

# Search for existing apps
find / -type d -name "APPS" 2>/dev/null
find / -type d -name "Roms" 2>/dev/null
find / -type d -name "ports" 2>/dev/null

# Check mounted SD cards
mount | grep -i sd
df -h | grep -i sd
```

### Method 2: Browse SD Card on Computer
1. Remove SD card from RG34xxsp
2. Insert into computer
3. Look for these folders:
   - `Roms/APPS/`
   - `roms/ports/`
   - `Tools/`
   - `userdata/roms/ports/`

### Method 3: Check Through File Manager
If your device has a file manager app:
1. Open file manager
2. Look for existing apps/games
3. Note their location

## Alternative Installation Methods:

### Option A: Create the Directory
If `/Roms/` exists but `/Roms/APPS/` doesn't:
```bash
mkdir -p /mnt/sdcard/Roms/APPS/Calculator/
# Or wherever your SD card is mounted
```

### Option B: Manual Path
Tell me what directories you DO have, and I can:
1. Modify the calculator to work with your structure
2. Create a custom installer script
3. Package it for your specific firmware

## What to Share:

Please tell me:
1. **Firmware name/version** you're running
2. **What folders exist** on your SD card (like Roms, roms, PORTS, etc.)
3. **Where other apps/games** are located (if you have any installed)

Then I can give you exact instructions for your setup!
