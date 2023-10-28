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
	@docker-compose -f ${DOCKER_COMPOSE} up --build -d

connect:
	@echo "$(YELLOW)Connecting to mariadb container ... $(NC)"
	@docker exec -it mariadb bash

clean: 	
	@echo "Shutting down containers..."
	@docker-compose -f srcs/docker-compose.yml down

fclean: clean
	@echo "$(RED)Deleting all images ... $(NC)"
	@docker image prune -af > /dev/null 2>&1
	@echo "$(RED)Deleting Docker volumnes ... $(NC)"
	@docker volume rm -f mariadb_data > /dev/null 2>&1
	@docker volume rm -f wordpress_data > /dev/null 2>&1
	@sudo rm -rf /home/ikgonzal/data

re: fclean all

.PHONY: all connect clean fclean re
