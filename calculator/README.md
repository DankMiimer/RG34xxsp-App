# Calculator App for RG34xxsp

A full-featured calculator application for the Anbernic RG34xxsp handheld gaming console.

![Calculator App](https://img.shields.io/badge/Platform-RG34xxsp-blue)
![Language](https://img.shields.io/badge/Language-C-green)
![SDL2](https://img.shields.io/badge/Framework-SDL2-orange)

## Features

- ✨ Clean, modern calculator interface
- 🔢 Basic arithmetic operations (+, -, *, /)
- 📊 Decimal point support
- 🎮 D-Pad navigation
- ⌨️ Keyboard support (for testing on PC)
- 🎨 Color-coded buttons (numbers, operators, special functions)
- 🖥️ Optimized for 720x480 resolution
- 💡 Error handling (division by zero, overflow)

## Calculator Layout

```
┌─────────────────────────────────────┐
│         Display: 0                  │
├──────┬──────┬──────┬──────┬─────────┤
│  C   │  (   │  )   │  /   │   AC    │
├──────┼──────┼──────┼──────┼─────────┤
│  7   │  8   │  9   │  *   │   DEL   │
├──────┼──────┼──────┼──────┼─────────┤
│  4   │  5   │  6   │  -   │    .    │
├──────┼──────┼──────┼──────┼─────────┤
│  1   │  2   │  3   │  +   │    0    │
└──────┴──────┴──────┴──────┴─────────┘
```

## Controls

### On RG34xxsp:
- **D-Pad**: Navigate between buttons
- **A Button**: Press the selected button
- **Menu/Select**: Exit calculator

### On PC (for testing):
- **Arrow Keys**: Navigate buttons
- **Enter/Space**: Press selected button
- **Number Keys (0-9)**: Direct number input
- **+, -, *, /**: Operators
- **= or Enter**: Calculate result
- **C**: Clear display
- **Delete**: Clear all
- **Backspace**: Delete last digit
- **ESC or Q**: Quit

## Button Functions

- **0-9**: Number input
- **+**: Addition
- **-**: Subtraction
- **×**: Multiplication
- **÷**: Division
- **.**: Decimal point
- **C**: Clear current number
- **AC**: All Clear (reset calculator)
- **DEL**: Delete last digit
- **(  )**: Parentheses (reserved for future use)

## Building from Source

### Requirements

1. **ARM64 Cross-Compiler**:
   ```bash
   sudo apt update
   sudo apt install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
   ```

2. **SDL2 Libraries for ARM64**:
   - SDL2
   - SDL2_ttf
   - libfreetype

   You can download precompiled libraries from [Arch Linux ARM](https://archlinuxarm.org/):
   - [SDL2 for aarch64](https://archlinuxarm.org/packages/aarch64/sdl2)
   - [SDL2_ttf for aarch64](https://archlinuxarm.org/packages/aarch64/sdl2_ttf)

   Extract the libraries to:
   - `SDL2/lib/` - Place libSDL2.so and libSDL2_ttf.so here
   - `SDL2/include/` - Place SDL2 headers here

### Build Instructions

1. **Clone or download this repository**

2. **Run the build script**:
   ```bash
   ./build.sh
   ```

   Or use make directly:
   ```bash
   make
   ```

3. **Build output** will be in the `build/` directory:
   - `calculator` - The executable
   - `calculator.sh` - Launch script

## Installation on RG34xxsp

### Method 1: SSH Transfer (Recommended)

1. **Enable SSH** on your RG34xxsp (check your firmware documentation)

2. **Transfer files**:
   ```bash
   ssh root@<device-ip> "mkdir -p /mnt/sdcard/Roms/APPS/Calculator"
   scp build/* root@<device-ip>:/mnt/sdcard/Roms/APPS/Calculator/
   ```

3. **Set permissions**:
   ```bash
   ssh root@<device-ip> "chmod +x /mnt/sdcard/Roms/APPS/Calculator/calculator*"
   ```

### Method 2: SD Card Transfer

1. **Remove the SD card** from your RG34xxsp

2. **Mount on your computer**

3. **Create directory**: `/Roms/APPS/Calculator/`

4. **Copy files**:
   - Copy all files from `build/` to the Calculator directory
   - Make sure `calculator` and `calculator.sh` are executable

5. **Insert SD card** back into device

### Launching

1. Power on your RG34xxsp
2. Navigate to **APPS** menu
3. Select **Calculator**
4. Enjoy!

## Project Structure

```
calculator/
├── src/
│   └── calculator.c      # Main application source code
├── SDL2/                 # SDL2 libraries (ARM64)
│   ├── lib/
│   │   ├── libSDL2.so
│   │   └── libSDL2_ttf.so
│   └── include/
│       └── SDL2/         # SDL2 header files
├── build/                # Compiled output
│   ├── calculator        # Executable binary
│   └── calculator.sh     # Launch script
├── Makefile              # Build configuration
├── build.sh              # Build script
├── calculator.sh         # Launch script template
└── README.md             # This file
```

## Technical Details

### Specifications

- **Language**: C99
- **Graphics**: SDL2 (Simple DirectMedia Layer)
- **Font Rendering**: SDL2_ttf
- **Architecture**: ARM64/AARCH64
- **Screen Resolution**: 720x480
- **Target Device**: Anbernic RG34xxsp (H700 chipset)

### Code Highlights

- **Display**: 16-digit precision with automatic formatting
- **Error Handling**: Division by zero, overflow, underflow
- **Number Formatting**: Automatic scientific notation for very large/small numbers
- **State Management**: Maintains operation state for chained calculations
- **Memory Efficient**: Minimal memory footprint suitable for embedded devices

## Development

### Testing on PC

You can test the calculator on your development machine:

1. **Install SDL2 development libraries**:
   ```bash
   sudo apt install libsdl2-dev libsdl2-ttf-dev
   ```

2. **Compile for x86-64**:
   ```bash
   gcc -std=c99 src/calculator.c -o calculator -lSDL2 -lSDL2_ttf -lm
   ```

3. **Run**:
   ```bash
   ./calculator
   ```

### Debugging

- Use `printf` statements for debugging (output to console)
- Test on PC first before deploying to device
- Check SDL error messages with `SDL_GetError()`

## Known Limitations

- Parentheses buttons are placeholders (not yet implemented)
- No memory functions (M+, M-, MR, MC)
- No scientific functions (sin, cos, tan, etc.)
- Maximum display: 16 characters

## Future Enhancements

- [ ] Parentheses support for complex expressions
- [ ] Memory functions
- [ ] Scientific mode (trig, log, exp functions)
- [ ] Calculation history
- [ ] Theme customization
- [ ] Button click sounds
- [ ] Portrait mode support

## Troubleshooting

### Build Issues

**Error: aarch64-linux-gnu-gcc not found**
```bash
sudo apt install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
```

**Error: SDL2 libraries not found**
- Download SDL2 libraries for ARM64 from archlinuxarm.org
- Place in `SDL2/lib/` and `SDL2/include/` directories

### Runtime Issues

**Calculator doesn't launch**
- Ensure executable permissions: `chmod +x calculator calculator.sh`
- Check that SDL2 libraries are in the same directory
- Verify font path in source code matches your system

**Font not found error**
- The app tries multiple font paths
- Copy a TrueType font to the app directory as `font.ttf`
- Or modify the font path in `calculator.c`

## License

This project is open source and available for modification and distribution.

## Credits

- Developed for Anbernic RG34xxsp
- Uses SDL2 library
- Font rendering via SDL2_ttf

## Support

For issues, questions, or contributions, please open an issue in the repository.

---

**Enjoy calculating on your RG34xxsp! 🧮**
