FROM debian:bullseye

RUN apt-get update && \
apt-get install mariadb-server -y && \
apt-get install mariadb-client -y

COPY script.sh /

RUN chmod +x /script.sh

CMD ["/script.sh"]