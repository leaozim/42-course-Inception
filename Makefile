NAME 			:= inception
COMPOSE			:= srcs/docker-compose.yml
VOLUMES_PATH	:= /home/$(USER)/data

all: build

up:
	@printf "Launch configuration $(NAME)...\n"
	@docker-compose -f $(COMPOSE) --env-file srcs/.env up -d

build: setup
	@printf "Building configuration $(NAME)...\n"
	@docker-compose -f $(COMPOSE) --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration $(NAME)...\n"
	@docker-compose -f $(COMPOSE) --env-file srcs/.env down

re: down
	@printf "Rebuild configuration $(NAME)...\n"
	@docker-compose -f $(COMPOSE) --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration $(NAME)...\n"
	@-docker system prune -a
	@-sudo rm -rf ~/data/

fclean:
	@printf "Total clean of all configurations docker\n"
	@-docker stop $$(docker ps -qa)
	@-docker system prune --all --force --volumes
	@-docker network prune --force
	@-docker volume prune --force
	@-docker volume rm srcs_db-volume
	@-docker volume rm srcs_wp-volume
	@sudo rm -rf ~/data/

ls:
	docker container ls
	docker image ls
	docker volume ls
	docker network ls -f type=custom

links:
	@echo
	@echo "Mandatory:"
	@echo " Wordpress\t\t: https://lade-lim.42.fr/"
	@echo " Wordpress Admin\t: https://lade-lim.42.fr/wp-admin"

setup:
	export VOLUMES_PATH
	sudo mkdir -p $(VOLUMES_PATH)/wordpress
	sudo mkdir -p $(VOLUMES_PATH)/mariadb
	grep $(LOGIN).42.fr /etc/hosts || echo "127.0.0.1 $(LOGIN).42.fr" >> /etc/hosts

.PHONY: all build down re clean fclean ls links