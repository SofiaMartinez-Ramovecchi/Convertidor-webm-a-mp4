FROM debian:stable-slim

RUN apt update && \
    apt install -y ffmpeg parallel make bash && \
    apt clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
