#!/usr/bin/env bash

set -e
shopt -s nullglob

mkdir -p corruptos

echo "Validando archivos WebM..."

files=(*.webm)

if [ ${#files[@]} -eq 0 ]; then
  echo "No se encontraron archivos .webm"
  exit 0
fi

for f in "${files[@]}"; do
  if ! ffmpeg -v error -i "$f" -f null - 2>/dev/null; then
    echo "Moviendo corrupto: $f"
    mv "$f" corruptos/
  fi
done

echo "Validación completada."
