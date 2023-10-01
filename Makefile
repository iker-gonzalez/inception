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
	@docker-compose -f $(COMPOSE_FILE) down
	@-docker stop `docker ps -qa`
	@-docker rm `docker ps -qa`
	@echo "$(RED)Deleting all images ... $(NC)"
	@-docker rmi -f `docker images -qa`
	@echo "$(RED)Deleting all volumes ... $(NC)"
	@-docker volume rm `docker volume ls -q`
	@echo "$(RED)Deleting all network ... $(NC)"
	@-docker network rm `docker network ls -q`
	@echo "$(RED)Deleting all data ... $(NC)"
	@sudo rm -rf /home/llescure/data/wordpress
	@sudo rm -rf /home/llescure/data/mysql
	@echo "$(RED)Deleting all $(NC)"

.PHONY: build all re down clean clean-images