FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

COPY script.sh /

RUN chmod +x /script.sh

CMD ["/script.sh"]