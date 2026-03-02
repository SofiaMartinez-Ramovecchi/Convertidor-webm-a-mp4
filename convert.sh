#!/usr/bin/env bash

# ==========================================
# WebM → MP4 Batch Converter
# ==========================================
# Usa GNU parallel para convertir en paralelo
# Requiere: ffmpeg + parallel
# ==========================================

set -e

JOBS=10
THREADS=1
PRESET=fast

echo "Iniciando conversión con $JOBS jobs paralelos..."

parallel -j "$JOBS" \
  'ffmpeg -y -threads '"$THREADS"' -i {} -c:v libx264 -preset '"$PRESET"' -c:a aac {.}.mp4' \
  ::: *.webm

echo "Conversión finalizada."
