# Define ANSI escape codes for colors
YELLOW=\033[1;33m
GREEN=\033[1;32m
RED=\033[31m
NC=\033[0m  # No Color

DOCKER_COMPOSE=./srcs/docker-compose.yml

all:
	@echo "$(YELLOW)Building directory for volumes ... $(NC)"
	@sudo mkdir -p /home/ikgonzal/data/wordpress
	@sudo mkdir -p /home/ikgonzal/data/mysql
	@echo "$(YELLOW)Building containers ... $(NC)"
	@ docker compose -f ${DOCKER_COMPOSE} up --build

clean: 	
	@echo "Shutting down containers..."
	@docker compose -f srcs/docker-compose.yml down

fclean: clean
	@echo "$(RED)Deleting Docker images ... $(NC)"
	@docker rmi -f $(docker images -qa)
	@echo "$(RED)Deleting Docker volumnes ... $(NC)"
	@docker volume rm $(docker volume ls -q)
	@echo "$(RED)Deleting Docker network ... $(NC)"
	@docker network rm $(docker network ls -q) 2>/dev/null

.PHONY: build all re down clean clean-images