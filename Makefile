all: build up

build:
	cd srcs && docker-compose build

up:
	cd srcs && docker-compose up

clean:
	cd srcs && docker-compose down --rmi local

fclean:
	cd srcs && docker-compose down --rmi all -v --remove-orphans
	docker system prune -af --volumes

re: fclean all

.PHONY: all clean fclean re