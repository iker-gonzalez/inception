# Define ANSI escape codes for colors
YELLOW=\033[1;33m
GREEN=\033[1;32m
RED=\033[31m
NC=\033[0m  # No Color

DOCKER_COMPOSE=./srcs/docker-compose.yml

all:
	@echo "$(YELLOW)Building files for volumes ... $(NC)"
	@sudo mkdir -p /home/ikgonzal/data/wordpress
	@sudo mkdir -p /home/ikgonzal/data/mysql
	@echo "$(YELLOW)Building containers ... $(NC)"
	@ docker compose -f ${DOCKER_COMPOSE} up --build

list:	
	@echo "$(YELOOW)Listing all containers ... $(NC)"
	 docker ps -a

list_volumes:
	@echo "$(YELLOW)Listing volumes ... $(NC)"
	docker volume ls

clean: 	
	@echo "$(RED)Stopping containers ... $(NC)"
	@if docker ps -a | grep -q 'mariadb'; then docker stop mariadb; fi
	@if docker ps -a | grep -q 'wordpress'; then docker stop wordpress; fi
	@if docker ps -a | grep -q 'nginx'; then docker stop nginx; fi
	@if docker ps -a | grep -q 'mariadb'; then docker rm mariadb; fi
	@if docker ps -a | grep -q 'wordpress'; then docker rm wordpress; fi
	@if docker ps -a | grep -q 'nginx'; then docker rm nginx; fi
	@echo "$(RED)Deleting all images ... $(NC)"
	@docker image prune -a
	@echo "$(RED)Deleting all volumes ... $(NC)"
	@-docker volume ls -q | xargs -I {} docker volume rm {}
	@echo "$(RED)Deleting all network ... $(NC)"
	@if docker network ls | grep -q srcs_docker-network; then \
		docker network rm srcs_docker-network; \
	fi
	@echo "$(RED)Deleting all data ... $(NC)"
	@sudo rm -rf /home/ikgonzal/data/wordpress
	@sudo rm -rf /home/ikgonzal/data/mysql
	@echo "$(RED)Deleting all $(NC)"

.PHONY: build all re down clean clean-images