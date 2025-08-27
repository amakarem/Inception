DOCKER_COMPOSE = docker compose
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

HOME_DIR = $(HOME)/data
MYSQL_DIR = $(HOME_DIR)/mysql
WP_DIR = $(HOME_DIR)/wordpress
STATIC_DIR = $(HOME_DIR)/js

.PHONY: kill build down clean fclean restart

build:
	mkdir -p $(MYSQL_DIR) $(WP_DIR) $(STATIC_DIR)
	HOST_DATA_DIR=$(HOME_DIR) $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up --build -d

kill:
	HOST_DATA_DIR=$(HOME_DIR) $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) kill

down:
	HOST_DATA_DIR=$(HOME_DIR) $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down

up:
	HOST_DATA_DIR=$(HOME_DIR) $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d

clean:
	HOST_DATA_DIR=$(HOME_DIR) $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v

fclean: clean
	rm -rf $(MYSQL_DIR)
	rm -rf $(WP_DIR)
	rm -rf $(STATIC_DIR)
	docker system prune -a -f

restart: clean build
