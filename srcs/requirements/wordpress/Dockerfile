FROM alpine:3.18

# 패키지 리스트를 업데이트하고 필요한 패키지 설치
RUN apk update && apk add --no-cache \
    php8 \
    php8-fpm \
    php8-opcache \
    php8-mysqli \
    php8-json \
    php8-openssl \
    php8-curl \
    php8-mbstring \
    php8-phar \
    php8-xml \
    php8-iconv \
    php8-dom \
    curl \
	dumb-init

# 작업 디렉토리 설정
WORKDIR /wordpress

# WP-CLI 설치 및 설정
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    wp cli update --allow-root

# WordPress 다운로드 및 설정
RUN wp core download --allow-root --path=/wordpress

# WordPress 설정 스크립트 및 엔트리포인트 스크립트 복사
COPY ./tools/wp-config.sh /usr/local/bin/wp-config
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint

# 스크립트 권한 설정
RUN chmod +x /usr/local/bin/wp-config /usr/local/bin/entrypoint
RUN chmod +x /usr/bin/wp-config

# WordPress 파일 및 데이터베이스를 위한 볼륨 설정
VOLUME ["/var/www/html", "/var/lib/mysql"]

# 네트워킹 구성
EXPOSE 9000

# 컨테이너 시작 설정
ENTRYPOINT ["dumb-init", "--"]
CMD ["/usr/local/bin/entrypoint"]