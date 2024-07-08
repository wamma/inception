#!/bin/sh

# MariaDB 서버가 준비될 때까지 기다립니다(경로에 없음)
# /wait-for-it.sh mariadb:3306 --timeout=60

# wp-config.sh를 실행하여 WordPress 설정을 수행
# /usr/local/bin/wp-config
set -e

# PHP-FPM을 시작합니다
php-fpm -F