FROM jrottenberg/ffmpeg:3.4-alpine

RUN mkdir /input && mkdir /output
COPY 1080p60_source_10sec.mkv /input

COPY entrypoint.sh /
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]