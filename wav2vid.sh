#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input> <output>";
    exit 1;
fi

INPUT_PATH = "$1";
OUTPUT_PATH = "$2";

if [ ! -f "$INPUT_PATH" ]; then
    echo "Error: The input file does not exist: $INPUT_PATH";
fi

ffmpeg -f lavfi -i color=color=black:size=1920x1080:rate=30 \
    -i "$INPUT_PATH" \
    -c:v libx264 -preset ultrafast -tune stillimage -pix_fmt yuv420p \
    -c:a copy -shortest "$OUTPUT_PATH";

if [ $? -eq 0 ]; then
    echo "Success: $OUTPUT_PATH";
else
    echo "Fail";
    exit 1;
fi

# chmod 755 wav2vid.sh
