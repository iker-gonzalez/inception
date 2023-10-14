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
	@echo "Shutting down containers..."
	@docker compose -f srcs/docker-compose.yml down

fclean: clean
	@echo "$(RED)Deleting all images ... $(NC)"
	@docker image prune -a
	@echo "$(RED)Deleting data from mariadb database ... $(NC)"
	@sudo rm -rf /home/ikgonzal/data/mysql
	@echo "$(RED)Deleting stored website files ... $(NC)"
	@sudo rm -rf /home/ikgonzal/data/wordpress

.PHONY: build all re down clean clean-images