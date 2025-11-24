#!/bin/bash
# System check script for KNULLI
echo "=== KNULLI System Information ==="
echo ""
echo "1. glibc version:"
ldd --version 2>&1 | head -1
echo ""
echo "2. Available libc:"
ls -lh /lib/libc.so* /lib/aarch64*/libc.so* 2>/dev/null
echo ""
echo "3. SDL2 libraries:"
ls -lh /usr/lib/libSDL2* 2>/dev/null | head -5
echo ""
echo "4. Architecture:"
uname -m
echo ""
echo "5. Kernel:"
uname -r
echo ""
echo "=== Please share this output ==="
