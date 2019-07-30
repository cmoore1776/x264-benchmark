# x264-benchmark

A simplified benchmark for video encoding performance, specifically designed for 1080p and 720p live streaming, e.g. to Twitch.

## usage

The easiest way to run the benchmark is to just run the bare image:

```
docker run --rm -it shamelesscookie/x264-benchmark:latest
```


By default, the ffmpeg `-threads` parameter will be set to half the number of logical CPU cores available to docker. This is designed to approximate how much processing power you'd be able to give to x264 if you were performing encoding on the same machine as the game or application you are streaming.

You can override this by setting the `THREADS` environment variable, e.g. to `0` to use all cores, but keep in mind that if you are using the encoding PC for other tasks (especially playing games), you should not expect to use all cores for encoding.

```
docker run --rm -it -e THREADS=0 shamelesscookie/x264-benchmark:latest
```


## interpreting output

The benchmark encodes a 10-second action clip from 3DMark Skydiver at 6000K ([Twitch's maximum recommended bitrate](https://stream.twitch.tv/encoding/)) and at various resolutions, framerates, and presets. It then outputs the encoding speed as a multiple of framerate. This is meant to indicate how likely your system will be able to encode at those settings.

Combinations that can run in < 10s should be safe to stream at.

Here's some sample results from an i7 8700k utilizing all cores (THREADS=0):

```
resolution:   1280x720 @ 30 fps
 ultrafast:   0m  5.57s
 superfast:   0m  5.66s
  veryfast:   0m  6.27s
    faster:   0m  7.00s
      fast:   0m  7.31s
    medium:   0m  7.67s
      slow:   0m  8.28s

resolution:   1280x720 @ 60 fps
 ultrafast:   0m  6.10s
 superfast:   0m  6.75s
  veryfast:   0m  7.32s
    faster:   0m  8.54s
      fast:   0m  9.27s
    medium:   0m  8.83s
      slow:   0m 11.01s

resolution:  1920x1080 @ 30 fps
 ultrafast:   0m  4.78s
 superfast:   0m  5.95s
  veryfast:   0m  8.88s
    faster:   0m 11.63s
      fast:   0m 13.33s
    medium:   0m 12.70s
      slow:   0m 13.81s

resolution:  1920x1080 @ 60 fps
 ultrafast:   0m  4.15s
 superfast:   0m  5.53s
  veryfast:   0m  8.17s
    faster:   0m 11.58s
      fast:   0m 13.23s
    medium:   0m 12.75s
      slow:   0m 14.96s
 ```

 For reference, the source file is 1920x1080 @ 120fps x265 (not x264) crf=23 (approx. 22,700K).