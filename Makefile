# Build a container via the command "make build"
# By Jason Gegere <jason@htmlgraphic.com>

VERSION 			= 1.1.2
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
	@echo "     make run		- Run $(NAME) container"
	@echo "     make start		- Start the EXISTING $(NAME) container"
	@echo "     make stop		- Stop $(NAME) container"
	@echo "     make restart	- Stop and start $(NAME) container"
	@echo "     make remove	- Stop and remove $(NAME) container"
	@echo "     make state		- View state $(NAME) container"
	@echo "     make logs		- Tail logs on running instance"

build:
	@echo "Build image $(IMAGE_NAME):$(VERSION)"
	docker build --rm --no-cache -t $(IMAGE_NAME):$(VERSION) .

push:
	docker push $(IMAGE_NAME):$(VERSION)

run:
	@echo "Run $(NAME)..."
	docker run -d --restart=always -p 25:25 --name $(NAME) -e LOG_TOKEN=$(LOG_ENTRIES_TOKEN) -e USER=username -e PASS=password -e HOST=$(HOST) $(IMAGE_NAME):$(VERSION)

start:
	@echo "Starting $(NAME)..."
	docker start $(NAME) > /dev/null

stop:
	@echo "Stopping $(NAME)..."
	docker stop $(NAME) > /dev/null

restart: stop start

remove: stop
	@echo "Removing $(NAME)..."
	docker rm $(NAME) > /dev/null

state:
	docker ps -a | grep $(NAME)

logs:
	@echo "Build $(NAME)..."
	docker logs -f $(NAME)
