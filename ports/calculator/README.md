# Calculator

## Description

A full-featured calculator application designed for the RG34xxsp handheld device running KNULLI Gladiator 2.

## Features

- Basic arithmetic operations: Addition (+), Subtraction (-), Multiplication (×), Division (÷)
- Decimal point support for precise calculations
- 16-digit precision display with automatic formatting
- Clear (C), All Clear (AC), and Delete (DEL) functions
- Error handling for division by zero and overflow conditions
- Color-coded buttons for intuitive navigation
- Optimized for 720x480 resolution

## Controls

- **D-Pad**: Navigate between calculator buttons
- **A Button**: Press the selected button
- **B Button / Start / Select**: Exit the calculator

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

## Installation

This port is designed for installation via PortsMaster. The calculator will appear in your Ports menu after installation.

## Technical Details

- **Language**: C99
- **Graphics**: SDL2 (Simple DirectMedia Layer)
- **Font Rendering**: SDL2_ttf
- **Architecture**: ARM64/AARCH64
- **Target Device**: RG34xxsp with KNULLI Gladiator 2

## Attribution

- Developed for PortsMaster distribution
- Built with SDL2 and SDL2_ttf libraries
- Packaged for KNULLI Gladiator 2 by Claude

## License

This calculator application is open source and available for modification and distribution.

## Source Code

The calculator is built from C source code using SDL2 for graphics rendering and input handling. The application maintains minimal memory footprint suitable for embedded handheld devices.
