# x264-benchmark

A simplified benchmark for video encoding performance, specifically designed for 1080p and 720p live streaming, e.g. to Twitch.

## usage

The easiest way to run the benchmark is to just run the bare image:
```
docker run --rm -it shamelesscookie/x264-benchmark:latest
```

By default, `THREADS` will be set to half the number of CPU cores available to docker. This is designed to approximate how much processing power you'd be able to give to x264 if you were performing encoding on the same machine as the game or application you are streaming.

You can override this by setting the `THREADS` environment variable, e.g. to `0` to use all cores, but keep in mind that if you are using the encoding PC for other tasks (especially playing games), you should not expect to use all cores for encoding.

```
docker run --rm -it -e THREADS=0 shamelesscookie/x264-benchmark:latest
```

## interpreting output

The benchmark encodes a 10-second action clip from Heroes of the Storm at 6000K ([Twitch's maximum recommended bitrate](https://stream.twitch.tv/encoding/)) and at various resolutions, framerates, and presets. It then outputs the encoding speed as a multiple of framerate. This is meant to indicate how likely your system will be able to encode at those settings.

Combinations that result in 1.5x or greater should be safe to stream at, but use your judgement. Certainly 1.0x or below will be too difficult.

```
resolution:  1920x1080 @ 60 fps
      slow:     0.665x
    medium:      1.07x
      fast:      1.28x
    faster:      1.43x
  veryfast:       2.3x
 superfast:      3.58x
 ultrafast:      5.11x

resolution:  1920x1080 @ 30 fps
      slow:     0.923x
    medium:      1.61x
      fast:      2.01x
    faster:      2.41x
  veryfast:      3.69x
 superfast:      4.54x
 ultrafast:      5.78x

resolution:   1280x720 @ 60 fps
      slow:      0.97x
    medium:      1.68x
      fast:      1.94x
    faster:      2.55x
  veryfast:      2.87x
 superfast:      3.36x
 ultrafast:      3.68x

resolution:   1280x720 @ 30 fps
      slow:      1.28x
    medium:      2.31x
      fast:      2.62x
    faster:      3.08x
  veryfast:       3.4x
 superfast:      3.64x
 ultrafast:      3.84x
 ```

 For reference, the source file is 1920x1080 @ 60fps x265 (not x264) qp=20 (approx. 10000K).