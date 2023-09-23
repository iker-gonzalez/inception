all:
	@ docker compose -f srcs/docker-compose.yml up --build

down:
	@docker compose -f ./scrs/docker-compose.yml down

re:
	@docker compose -f scrs/docker-compose.yml up -d --build

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\

clean-images:
	@docker rmi -f $$(docker images -qa);\

.PHONY: all re down clean clean-images