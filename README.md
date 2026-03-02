# WebM Batch Converter

## Objetivo
En base a la necesidad de convertir archivos webm a mp4, y no tener herramientas gratuitas para hacerlo, cree este programa multiplataforma que lo hace, open source, simple minimalista y con un archivo make para que lo ejecutes facil en tu pc.

## Resumen
Convierte archivos .webm a .mp4 usando ffmpeg y procesamiento paralelo.

## Características:

Conversión en paralelo usando todos los cores

Detección y aislamiento de archivos corruptos

Soporte multiplataforma mediante Docker

No reconvierte archivos si no existen .webm

## Flujo reproducible

## Requisitos
Opción 1 — Sin Docker (Linux)

Necesitás:

ffmpeg

GNU parallel

make

bash

Instalar en Debian/Kali/Ubuntu:

sudo apt update
sudo apt install ffmpeg parallel make bash
## Opción 2 — Con Docker (recomendado, multiplataforma)

Solo necesitás:

Docker

Funciona en:

Linux

macOS

Windows (Docker Desktop)

Uso

Colocá tus archivos .webm en la raíz del proyecto.

# ▶️ Ejecutar local (sin Docker)
make run

Flujo:

Crea carpeta corruptos/

Valida archivos .webm

Mueve los corruptos

Convierte los válidos a .mp4 en paralelo

# 🐳 Ejecutar con Docker
Construir imagen
make docker-build
Ejecutar conversión
make docker-run

Docker:

Monta tu directorio actual dentro del contenedor

Usa todos los cores disponibles

Deja los .mp4 en tu carpeta real

🧹 Limpiar archivos generados
make clean

Elimina los .mp4 generados.

## Comportamiento esperado

Si no hay archivos .webm:

No hay archivos .webm para convertir

Si un archivo está corrupto o no es WebM real:

Se moverá automáticamente a:

corruptos/

## Estructura del proyecto
.
├── Dockerfile
├── Makefile
├── corruptos/
├── archivo1.webm
├── archivo1.mp4
Parámetros técnicos

## Conversión usa:

Video codec: libx264

Audio codec: aac

Preset: fast

1 thread por proceso

N procesos = cantidad de cores detectados

## Notas importantes

El archivo debe ser WebM real (contenedor Matroska/WebM).

Si un archivo tiene extensión .webm pero no es realmente WebM, será movido a corruptos/.

No se ejecuta nada automáticamente fuera del directorio actual.

## Ejemplo rápido
git clone <repo>
cd Convertidor-webm-a-mp4
cp ~/Descargas/*.webm .
make docker-build
make docker-run
