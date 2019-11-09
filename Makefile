#!/bin/sh

# Build a container via the command "make build"
# By Jason Gegere <jason@htmlgraphic.com>

SHELL = /bin/sh

include .env # .env file needs to created for this to work properly

TAG 				= 1.1.6
CONTAINER		= postfix
IMAGE_REPO 	= htmlgraphic
IMAGE_NAME 	= $(IMAGE_REPO)/$(CONTAINER)
HOST				= post-office
DOMAIN			= htmlgraphic.com
NODE_ENV=$(shell grep NODE_ENVIRONMENT .env | cut -d '=' -f 2-)

ifeq ($(NODE_ENV),dev)
	COMPOSE_FILE = docker-compose.local.yml
else
	COMPOSE_FILE = docker-compose.yml
endif


all:: help


help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "	make build	- Build image $(IMAGE_NAME):$(TAG)"
	@echo "	make push	- Push $(IMAGE_NAME):$(TAG) to public docker repo"
	@echo "	make run	- Run docker-compose and create local development environment"
	@echo "	make start	- Start the EXISTING $(CONTAINER) container"
	@echo "	make stop	- Stop local environment build"
	@echo "	make restart	- Stop and start $(CONTAINER) container"
	@echo "	make rm		- Stop and remove $(CONTAINER) container"
	@echo "	make state	- View state $(CONTAINER) container"
	@echo "	make logs	- Tail logs on running instance"


env:
	@[ ! -f .env ] && echo "	.env file does not exist, copy env template \n" && cp .env.example .env || echo "	env file exists \n"
	@echo "The following environment varibles exist:"
	@echo $(shell sed 's/=.*//' .env)
	@echo ''

build:
	@echo "Build image $(IMAGE_NAME):$(TAG)"
	docker build --no-cache \
        --build-arg VCS_REF=`git rev-parse --short HEAD` \
        --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
        --rm -t $(IMAGE_NAME):$(TAG) --rm -t $(IMAGE_NAME):latest .

push:
	@echo "note: If the repository is set as an automatted build you will NOT be able to push"
	docker push $(IMAGE_NAME):$(TAG)

run:
	@echo 'Setting environment varibles...'
	@make env
	@echo "Run $(CONTAINER)..."
	docker-compose -f docker-compose.yml up -d

start:
	@echo "Starting $(CONTAINER)..."
	docker start $(CONTAINER) > /dev/null

stop:
	@echo "Stopping $(CONTAINER)..."
	docker-compose stop

restart: stop start

rm: stop
	@echo "Removing $(CONTAINER)..."
	docker rm $(CONTAINER) > /dev/null

state:
	docker ps -a | grep $(CONTAINER)

logs:
	@echo "Build $(CONTAINER)..."
	docker logs -f $(CONTAINER)
