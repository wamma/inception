#!/bin/sh

# MariaDB 서비스를 시작합니다.

openrc default

/etc/init.d/mariadb setup

rc-service mariadb start

# MariaDB 서버가 준비될 때까지 기다린다
# while ! mysqladmin ping --silent; do
# 	sleep 1
# done

echo "MariaDB is ready."

# 데이터베이스를 생성합니다.

mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"

# 사용자를 생성하고 권한을 부여합니다.
mysql -u root -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u root -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"

# MariaDB 서비스를 안전하게 종료합니다.
rc-service mariadb stop

mysqld_safe
