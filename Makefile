name 			:= inception
COMPOSE			:= srcs/docker-compose.yml
VOLUMES_PATH	:= /home/$(USER)/data

all: build

up:
	@printf "Launch configuration ${name}...\n"
# @bash srcs/requirements/wordpress/tools/set_initial_config.sh
	@docker-compose -f $(COMPOSE) --env-file srcs/.env up -d

build: setup
	@printf "Building configuration ${name}...\n"
# @bash srcs/requirements/wordpress/tools/set_initial_config.sh
	@docker-compose -f $(COMPOSE) --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f $(COMPOSE) --env-file srcs/.env down

re: down
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f $(COMPOSE) --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${name}...\n"
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
	grep VOLUMES_PATH srcs/.env || echo "VOLUMES_PATH=$(VOLUMES_PATH)" >> srcs/.env

.PHONY: all build down re clean fclean ls links