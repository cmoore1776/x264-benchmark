FROM jrottenberg/ffmpeg:3.4-alpine

RUN mkdir /input && mkdir /output
COPY skydiver_10sec.mp4 /input

COPY entrypoint.sh /
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]