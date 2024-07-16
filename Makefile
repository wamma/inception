all: build up

build:
	cd srcs && docker-compose build

up:
	cd srcs && docker-compose up

clean:
	cd srcs && docker-compose down --rmi local

fclean:
	cd srcs && docker-compose down -v --rmi all --remove-orphans
	-docker volume rm $(docker volume ls -q)
	docker system prune -af --volumes
	cd /home/hyungjup/data/db && sudo rm -rf *
	cd /home/hyungjup/data/wp && sudo rm -rf *

re: fclean all

.PHONY: all clean fclean re