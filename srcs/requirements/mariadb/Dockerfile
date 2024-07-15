FROM debian:bullseye

CMD ["/script.sh"]

RUN apt-get update && \
apt-get install mariadb-server -y && \
apt-get install mariadb-client -y

COPY script.sh /

RUN chmod +x /script.sh

