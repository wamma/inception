#!/bin/bash

if [ ! -f /usr/local/bin/wp ]; then
    # WP-CLI 다운로드
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    # 실행 권한 부여 및 위치 이동
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    # WordPress 설치 디렉토리로 이동
    cd /var/www/html
    rm -rf *
    # WordPress 다운로드 및 설치
    wp core download --allow-root
    # wp-config.php 파일 생성
    wp config create \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb \
        --allow-root
    # WordPress 핵심 설치
    wp core install \
        --url=$WP_URL \
        --title="$WP_TITLE" \
        --admin_user=$WP_ADMIN_USERNAME \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --skip-email \
        --allow-root
    # 추가 사용자 생성
    wp user create $USER1 $USER1_EMAIL --user_pass=$PASS1 --allow-root
fi

# 디렉토리 권한 설정
chmod -R 777 /var/www

# PHP-FPM 설정 변경
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# 환경 변수 문제 해결
echo "clear_env = no" >> /etc/php/7.4/fpm/pool.d/www.conf

# PHP-FPM 런타임 디렉토리 생성
mkdir -p /run/php

# PHP-FPM 실행
exec /usr/sbin/php-fpm7.4 -F