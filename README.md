# LG_TV_Converter_Scripts
_sh scripts using FFMPEG to convert videos for my LG Tv, WebOS media player, and documentation for my forgetfulness_

## Requirements
- Needs ffmpeg installed and accessable from the terminal
    - Check if it's installed by calling `ffmpeg -h`
    - Needs to be added to the path properly

## Readable resources and references

### LG TV settings:

This reddit thread had a user complaining about their TV not playing the audio for an mkv and a number of recommendations in it about the compatibility of certain types of audio codecs that were not supported by the tv
> your files use Vorbis audio, which i doubt many devices can read. it probably has nothing to do with having dual tracks.
>
> what you probably want to do is convert it to aac audio.


https://www.reddit.com/r/techsupport/comments/2m2wkh/comment/cm1pk1i/?utm_source=share&utm_medium=web2x&context=3

Working backwards from that I searched around to find how to convert the audio using what I had seen as playable video based on the description in the thread also

Additionally LGTV has the following guide for WebOS TV developers

https://webostv.developer.lge.com/develop/specifications/video-audio-35

|Container|Video codecs|Audio codecs|
|---|---|---|
|mp3, mp4, move|H.264/AVC, MPEG-4, HEVC| Dolby Digital, Dolby Digital Plus, AAC, MPEG-1 Layer III (MP3)|
|mkv|MPEG-2, MPEG-4, H.264/AVC, VP8, VP9, HEVC|Dolby Digital, Dolby Digital Plus, AAC, PCM, DTS, MPEG-1 Layer I, II, MPEG-1 Layer III (MP3)|

### ffmpeg usage example from here:

https://superuser.com/questions/1551072/ffmpeg-how-do-i-re-encode-a-video-to-h-264-video-and-aac-audio

Included this command from the top comment

`ffmpeg -i input.avi -c:v libx264 -preset slow -crf 20 -c:a aac -b:a 160k -vf format=yuv420p -movflags +faststart output.mp4`

and this breakdown of usage:

---

`input.avi` is the input file.

`-c:v libx264` selects the video encoder libx264, which is a H.264 encoder.

`-preset slow` selects the slow x264 encoding preset. Default preset is medium. Use the slowest preset that you have patience for.

`-crf 20` selects a CRF value of 20 which will result in a high quality output. Default value is 23. A lower value is a higher quality. Use the highest value that gives an acceptable quality.

`-c:a aac` selects the audio encoder aac, which is the built-in FFmpeg AAC encoder.

`-b:a 160k` encodes the audio with a bitrate of 160k.

`-vf format=yuv420p` chooses YUV 4:2:0 chroma-subsampling which is recommended for H.264 compatibility.

`-movflags +faststart` is an option for MP4 output that move some data to the beginning of the file after encoding is finished. This allows the video to begin playing faster if it is watched via progressive download playback.

`output.mp4` is the output file.

---

also the links to the two codecs:

https://trac.ffmpeg.org/wiki/Encode/AAC

https://trac.ffmpeg.org/wiki/Encode/H.264
