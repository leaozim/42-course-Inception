name = inception

all: up 

up:
	@printf "Launch configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/set_initial_config.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/set_initial_config.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: down
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

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

.PHONY: all build down re clean fclean ls links