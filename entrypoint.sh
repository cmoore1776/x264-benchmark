#!/bin/sh

CORES=`grep -c ^processor /proc/cpuinfo`

if [ -z ${THREADS+x} ]; then THREADS=$(($CORES / 2)); fi

for resolution in 1280x720 1920x1080
do
  for framerate in 30 60
  do
    printf "\n%10s: %10s @ %2s fps\n" "resolution" ${resolution} ${framerate}
    for preset in ultrafast superfast veryfast faster fast
    do
      printf "%10s: " ${preset}
      FRAMERATE_2X=$(($framerate * 2))
      { time ffmpeg -hide_banner -loglevel quiet -i /input/skydiver_10sec.mp4 -c:v libx264 -profile:v high -s ${resolution} \
        -preset ${preset} -b:v 8000K -bufsize 8000K -r ${framerate} -g ${FRAMERATE_2X} -keyint_min ${FRAMERATE_2X} \
        -sws_flags lanczos -pix_fmt yuv420p -f null -c:a aac -b:a 128k -strict normal -an -threads ${THREADS} \
        - ; } 2> /output/${resolution}_${framerate}_${preset}.txt
      export SPEED=`cat /output/${resolution}_${framerate}_${preset}.txt | \
        head -n 1 | cut -f 2`
      printf "%4s%7s\n" ${SPEED}
    done
  done
done