FROM debian:bullseye

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y php7.4-fpm php7.4-mysql curl mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html
COPY script.sh /
RUN chmod +x /script.sh

EXPOSE 9000

CMD [ "/script.sh" ]