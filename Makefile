# Build a container via the command "make build"
# By Jason Gegere <jason@htmlgraphic.com>

VERSION 			= 1.1.3
NAME 				= postfix
IMAGE_REPO 	= htmlgraphic
IMAGE_NAME 	= $(IMAGE_REPO)/$(NAME)
HOST 				= post-office.htmlgraphic.com

all:: help


help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "     make build		- Build image $(IMAGE_NAME):$(VERSION)"
	@echo "     make push		- Push $(IMAGE_NAME):$(VERSION) to public docker repo"
	@echo "     make run		- Run docker-compose and create local development environment"
	@echo "     make start		- Start the EXISTING $(NAME) container"
	@echo "     make stop		- Stop local environment build"
	@echo "     make restart	- Stop and start $(NAME) container"
	@echo "     make rm		- Stop and remove $(NAME) container"
	@echo "     make state		- View state $(NAME) container"
	@echo "     make logs		- Tail logs on running instance"

build:
	@echo "Build image $(IMAGE_NAME):$(VERSION)"
	docker build --rm --no-cache -t $(IMAGE_NAME):$(VERSION) .

push:
	@echo "note: If the repository is set as an automatted build you will NOT be able to push"
	docker push $(IMAGE_NAME):$(VERSION)

run:
	@echo "Run $(NAME)..."
	docker-compose up -d

start:
	@echo "Starting $(NAME)..."
	docker start $(NAME) > /dev/null

stop:
	@echo "Stopping $(NAME)..."
	docker-compose stop

restart: stop start

rm: stop
	@echo "Removing $(NAME)..."
	docker rm $(NAME) > /dev/null

state:
	docker ps -a | grep $(NAME)

logs:
	@echo "Build $(NAME)..."
	docker logs -f $(NAME)
