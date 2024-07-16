#!/bin/sh

# 기존 MariaDB 프로세스 종료
killall -w -s 9 mariadbd

# MariaDB 구성 파일에서 'bind-address'를 '0.0.0.0'으로 설정
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

# MariaDB 실행
mysqld_safe &

# MariaDB 서버가 준비될 때까지 기다림
until mysqladmin ping -h localhost --silent; do
    echo "Waiting for database server to start..."
    sleep 2
done

# root 사용자 재설정
mysql -u root <<-EOSQL
    SET @@SESSION.SQL_LOG_BIN=0;
    DELETE FROM mysql.user WHERE User='root';
    FLUSH PRIVILEGES;
    CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
EOSQL

# 사용자 및 데이터베이스 생성
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo "MariaDB configuration completed."

# 마리아DB 서버 실행 계속 유지
wait