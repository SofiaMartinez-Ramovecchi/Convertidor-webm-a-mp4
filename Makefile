SHELL := /bin/bash
IMAGE_NAME=webm-converter
CPUS=$(shell nproc)

.PHONY: install clean run check convert docker-build docker-run

install:
	sudo apt update
	sudo apt install -y ffmpeg parallel make

check:
	mkdir -p corruptos
	shopt -s nullglob; \
	for f in *.webm; do \
		if ! ffmpeg -v error -i "$$f" -f null - 2>/dev/null; then \
			echo "Moviendo corrupto: $$f"; \
			mv "$$f" corruptos/; \
		fi; \
	done

convert:
	shopt -s nullglob; \
	files=(*.webm); \
	if [ $${#files[@]} -eq 0 ]; then \
		echo "No hay archivos .webm para convertir"; \
		exit 0; \
	fi; \
	parallel -j $(CPUS) 'ffmpeg -threads 1 -i {} -c:v libx264 -preset fast -c:a aac {.}.mp4' ::: *.webm

run: check convert

docker-build:
	docker build -t $(IMAGE_NAME) .

docker-run:
	docker run --rm \
		-v $(PWD):/app \
		--cpus="$(CPUS)" \
		$(IMAGE_NAME) \
		make run

clean:
	rm -f *.mp4
