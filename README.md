# WebM Batch Converter

Script profesional para:

1. Validar archivos `.webm`
2. Mover archivos corruptos a `/corruptos`
3. Convertir WebM válidos a MP4 en paralelo usando ffmpeg

---

## 📦 Requisitos

- ffmpeg
- GNU parallel

Instalación en Debian/Ubuntu:

```bash
sudo apt install ffmpeg parallel
🚀 Uso
1️⃣ Validar archivos
chmod +x validate_and_move_corrupt.sh
./validate_and_move_corrupt.sh

Esto moverá archivos corruptos a:

./corruptos
2️⃣ Convertir archivos válidos
chmod +x convert.sh
./convert.sh

Convierte todos los .webm restantes a .mp4.

⚙ Configuración

En convert.sh podés modificar:

JOBS=10       # Número de procesos paralelos
THREADS=1     # Threads por proceso ffmpeg
PRESET=fast   # ultrafast | veryfast | fast | medium | slow

Recomendación:

Usar JOBS = nproc - 2

Mantener THREADS=1 para control preciso de CPU

🧠 Notas técnicas

El validador usa:

ffmpeg -v error -i file.webm -f null -

Si ffmpeg no puede parsear el header EBML, el archivo se considera corrupto.

🏁 Flujo recomendado
./validate_and_move_corrupt.sh
./convert.sh
