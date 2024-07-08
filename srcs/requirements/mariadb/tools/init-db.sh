#!/bin/sh

# OpenRC 서비스 초기화
openrc default

# MariaDB 초기 설정
/etc/init.d/mariadb setup

# MariaDB 서비스 시작
rc-service mariadb start

# MariaDB 서버가 준비될 때까지 기다립니다
while ! mysqladmin ping --silent; do
    sleep 1
done

echo "MariaDB is ready."

# 데이터베이스가 이미 존재하는지 확인
# RESULT=`mysql -u root -e "SHOW DATABASES LIKE '$MYSQL_DATABASE';"`
RESULT=$(mysql -u root -e "SHOW DATABASES LIKE '$MYSQL_DATABASE';")
# if [ "$RESULT" == "" ]; then
if [ -z "$RESULT" ]; then
    # 데이터베이스 생성
    # mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"

    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

    # 사용자 생성 및 권한 부여
    # mysql -u root -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    # mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"
else
    echo "Database and user already exist."
fi

echo "MariaDB create success."

# MariaDB 서비스를 안전하게 종료합니다.
rc-service mariadb stop

# MariaDB 안전 실행
exec /usr/bin/mysqld_safe
