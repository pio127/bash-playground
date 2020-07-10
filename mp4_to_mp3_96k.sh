#!/bin/bash

if [ $# -ne 1 ]; then 
    echo "[Error] MP4 filepath needed as an argument." 
    exit 1; 
fi
filename=$1
filename_without_extension=$(echo "$filename" | cut -f 1 -d '.')
ffmpeg -i "$filename" -vn -ar 44100 -ac 2 -ab 96k -f mp3 "$filename_without_extension.mp3"
