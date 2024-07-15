#!/bin/sh

set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB Data Directory..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
fi

echo "Starting MariaDB server..."
/usr/bin/mysqld_safe --datadir='/var/lib/mysql' &

until mysqladmin ping --silent; do
    echo "Waiting for database connection..."
    sleep 2
done

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Creating database and user..."
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
fi

echo "MariaDB create success."

# MariaDB 안전 실행
wait # 이전 mysqld_safe 프로세스가 완료되기를 기다립니다
