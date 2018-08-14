#!/bin/sh

CORES=`grep -c ^processor /proc/cpuinfo`

if [ -z ${THREADS+x} ]; then THREADS=$(($CORES / 2)); fi

for resolution in 1920x1080 1280x720
do
  for framerate in 60 30
  do
    for preset in slow medium fast faster veryfast superfast ultrafast
    do
      FRAMERATE_2X=$(($framerate * 2))
      ffmpeg -i /input/1080p60_source_10sec.mkv -c:v libx264 -profile:v high -s ${resolution} \
      -preset ${preset} -b:v 6000K -bufsize 6000K -r ${framerate} -g ${FRAMERATE_2X} -keyint_min ${FRAMERATE_2X} \
      -sws_flags lanczos -pix_fmt yuv420p -f flv -c:a aac -b:a 128k -strict normal -an -threads ${THREADS} \
      -benchmark /output/${resolution}_${framerate}_${preset}.flv 2>&1 | tee -a /output/${resolution}_${framerate}_${preset}.txt
    done
  done
done

for resolution in 1920x1080 1280x720
do
  for framerate in 60 30
  do
    printf "\n%10s: %10s @ %2s fps\n" "resolution" ${resolution} ${framerate}
    for preset in slow medium fast faster veryfast superfast ultrafast
    do
      export SPEED=`cat /output/${resolution}_${framerate}_${preset}.txt | grep -Eo "[0-9]+\.[0-9]+x" | tail -n 1`
      printf "%10s: %10s\n" ${preset} ${SPEED}
    done
  done
done