# ==========================================
# WebM Batch Converter - Makefile
# ==========================================

SHELL := /bin/bash
CORES := $(shell nproc)
JOBS := $(shell echo $$(( $(CORES) > 2 ? $(CORES) - 2 : 1 )))

.PHONY: install chmod validate convert run clean help

help:
	@echo "Targets disponibles:"
	@echo "  make install   -> Instala dependencias (Debian/Ubuntu)"
	@echo "  make chmod     -> Da permisos a los scripts"
	@echo "  make validate  -> Valida y mueve corruptos"
	@echo "  make convert   -> Convierte WebM a MP4"
	@echo "  make run       -> Ejecuta flujo completo"
	@echo "  make clean     -> Elimina MP4 generados"

install:
	sudo apt update
	sudo apt install -y ffmpeg parallel

chmod:
	chmod +x validate_and_move_corrupt.sh
	chmod +x convert.sh

validate:
	./validate_and_move_corrupt.sh

convert:
	@if ls *.webm 1> /dev/null 2>&1; then \
		parallel -j $(JOBS) \
		  'ffmpeg -y -threads 1 -i {} -c:v libx264 -preset fast -c:a aac {.}.mp4' \
		  ::: *.webm; \
	else \
		echo "No hay archivos .webm para convertir."; \
	fi

run: chmod validate convert
	@echo "Proceso completo finalizado."

clean:
	rm -f *.mp4
