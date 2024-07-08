all: build run

build:
	docker build -t mariadb .

run:
	docker run --env-file ../../.env -d -p 3306:3306 --name mymysql mariadb

# Access the MySQL command line inside the container
exec:
	$(eval CONTAINER_ID=$(shell docker ps --format "{{.ID}}" --filter "name=mymysql"))
	@echo "Connecting to container $(CONTAINER_ID)"
	docker exec -it $(CONTAINER_ID) mysql -u root -p

stop:
	$(eval CONTAINER_ID=$(shell docker ps --format "{{.ID}}" --filter "name=mymysql"))
	@echo "Stopping container $(CONTAINER_ID)"
	docker stop $(CONTAINER_ID)

fclean: stop
	docker system prune -a --volumes --force

.PHONY: all clean fclean run