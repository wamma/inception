#!/bin/sh

# MariaDB 서버가 준비될 때까지 기다립니다
/wait-for-it.sh mariadb:3306 --timeout=60

# wp-config.sh를 실행하여 WordPress 설정을 수행
/usr/bin/wp-config

# PHP-FPM을 시작합니다
php-fpm8 -F