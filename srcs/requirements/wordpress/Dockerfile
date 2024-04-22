FROM alpine:3.18

# 패키지 리스트를 업데이트하고 필요한 패키지 설치
RUN apk update && apk add --no-cache \
vim \
dumb-init \
mariadb-client \
curl \
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
sendmail \
bash

# WP-CLI 설치 및 설정
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    wp cli update

# WordPress 다운로드 및 디렉토리 설정
RUN mkdir /wordpress && \
    wp core download --allow-root --path=/wordpress

# 호스트의 cmd.sh 스크립트 복사
COPY ./tools/cmd.sh /tools/cmd.sh

# 컨테이너 시작 시 dumb-init을 기본 엔트리포인트로 사용
ENTRYPOINT ["dumb-init", "--"]

# cmd.sh 스크립트 실행
CMD ["/tools/cmd.sh"]