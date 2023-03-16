#! /bin/bash
# https://www.freecodecamp.org/news/shell-scripting-crash-course-how-to-write-bash-scripts-in-linux/

INPUT_FILE=""
OUTPUT_FILE="S7E1.mp4"

ffmpeg -i $INPUT_FILE -c:v libx264 -preset slow -crf 20 -c:a aac -b:a 160k -vf format=yuv420p -movflags +faststart $OUTPUT_FILE