all: build up

build:
	docker-compose build

up:
	docker-compose up

clean:
	docker-compose down --rmi local

fclean:
	docker-compose down --rmi all -v --remove-orphans
	docker system prune -af --volumes

re: fclean all

.PHONY: all clean fclean re