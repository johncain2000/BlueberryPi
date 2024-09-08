#!/bin/bash

PROGRAMMER="arduino"
PORT="/dev/cu.usbserial-0001"
CHIP="attiny85"
BAUDRATE="19200"
BUILD_DIR="./build"

# Find the most recently modified .hex file in the build directory
HEX_FILE=$(find "$BUILD_DIR" -name "*.hex" -type f -exec stat -f "%m %N" {} \; | sort -rn | head -n 1 | awk '{print $2}')

# Check if a hex file was found
if [ -z "$HEX_FILE" ]; then
    echo "Error: No .hex file found in $BUILD_DIR"
    exit 1
fi

echo "Found hex file: $HEX_FILE"

# Flashing command
echo "Flashing $HEX_FILE to ATtiny85..."
avrdude -v -p $CHIP -c $PROGRAMMER -P $PORT -b $BAUDRATE -D -U flash:w:$HEX_FILE:i

# Check if avrdude was successful
if [ $? -eq 0 ]; then
    echo "Flashing completed successfully."
else
    echo "Error: Flashing failed."
    exit 1
fi