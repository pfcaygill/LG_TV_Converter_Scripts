#! /bin/bash
IMAGE_FILE="test_image.png"
VIDEO_FILE="output_raw_bitstream.h264"
VIDEO_FILE_LOOP_TIME=300
AUDIO_FILE="output_audio.aac"
TEMP_FILE="intermediate_result.mp4" 
OUTPUT_FILE="TEST.mp4"


echo "----------------------------------"
echo
echo
echo "           First Pass"
echo
echo
echo "----------------------------------"
# build them as individual streams, following this 
# https://stackoverflow.com/questions/45462731/using-ffmpeg-to-change-framerate#64251589

# create audio channel separately (sample sine wave)
ffmpeg -f lavfi -i "sine=frequency=1000:duration=300,volume=0.1" $AUDIO_FILE

# build video stream from input image
# https://shotstack.io/learn/use-ffmpeg-to-convert-images-to-video/
# use looping and a time limit to build the buffer length we need
# DO NOT REMOVE THE -t ARG, IT WILL RUN UNTIL YOU STOP IT OTHERWISE
ffmpeg -loop 1 -t $VIDEO_FILE_LOOP_TIME -i $IMAGE_FILE -c:v libx264 -r 30 -pix_fmt yuv420p -f h264 $VIDEO_FILE

# combine the two streams
ffmpeg -r 30 -i $VIDEO_FILE -i $AUDIO_FILE $TEMP_FILE


echo "----------------------------------"
echo
echo
echo "           Second Pass"
echo
echo
echo "----------------------------------"

# Original command
# adding -y to force overrides
ffmpeg -i $TEMP_FILE \
    -c:v libx264 -preset slow -crf 20 -c:a aac -b:a 160k -vf format=yuv420p -movflags +faststart \
    $OUTPUT_FILE


rm $VIDEO_FILE
rm $AUDIO_FILE
rm $TEMP_FILE