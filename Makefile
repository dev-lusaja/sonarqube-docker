.DEFAULT_GOAL := help

PROJECT_NAME = sonarqube

#Application config
CONTAINER_APP_NAME = sonarqube_app
CONTAINER_APP_PORT = 9000

# database config
CONTAINER_DB_NAME = sonarqube_db
CONTAINER_DB_PORT = 5432
DB_USER = sonar
DB_PASS = sonar
DB_NAME = sonar

#Network config
DOCKER_NETWORK = sonar_network

up: ## up docker containers
	@make verify_network &> /dev/null
	@CONTAINER_APP_NAME=$(CONTAINER_APP_NAME) \
	CONTAINER_APP_PORT=$(CONTAINER_APP_PORT) \
	CONTAINER_DB_NAME=$(CONTAINER_DB_NAME) \
	CONTAINER_DB_PORT=$(CONTAINER_DB_PORT) \
	DB_USER=$(DB_USER) \
	DB_PASS=$(DB_PASS) \
	DB_NAME=$(DB_NAME) \
	DOCKER_NETWORK=$(DOCKER_NETWORK) \
	docker-compose -p $(PROJECT_NAME) up -d
	@docker ps

down: ## Stop and remove the docker containers, use me with: make down
	@CONTAINER_APP_NAME=$(CONTAINER_APP_NAME) \
	CONTAINER_APP_PORT=$(CONTAINER_APP_PORT) \
	CONTAINER_DB_NAME=$(CONTAINER_DB_NAME) \
	CONTAINER_DB_PORT=$(CONTAINER_DB_PORT) \
	DB_USER=$(DB_USER) \
	DB_PASS=$(DB_PASS) \
	DB_NAME=$(DB_NAME) \
	DOCKER_NETWORK=$(DOCKER_NETWORK) \
	docker-compose -p $(PROJECT_NAME) down

ssh: ## Connect to container for ssh protocol
	docker exec -it $(CONTAINER_APP_NAME) bash

logs: ## Show docker logs
	@CONTAINER_APP_NAME=$(CONTAINER_APP_NAME) \
	CONTAINER_APP_PORT=$(CONTAINER_APP_PORT) \
	CONTAINER_DB_NAME=$(CONTAINER_DB_NAME) \
	CONTAINER_DB_PORT=$(CONTAINER_DB_PORT) \
	DB_USER=$(DB_USER) \
	DB_PASS=$(DB_PASS) \
	DB_NAME=$(DB_NAME) \
	DOCKER_NETWORK=$(DOCKER_NETWORK) \
	docker-compose -p $(PROJECT_NAME) logs -f

scanner: ## Run sonar scanner
	@docker run -ti -v $(PWD):/root/src --network=$(DOCKER_NETWORK) newtmitch/sonar-scanner:3.0.3

verify_network: ## Verify the local network was created in docker: make verify_network
	@if [ -z $$(docker network ls | grep $(DOCKER_NETWORK) | awk '{print $$2}') ]; then\
		(docker network create $(º));\
	fi

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'