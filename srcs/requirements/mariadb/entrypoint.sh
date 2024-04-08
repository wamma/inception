#!/bin/sh

# 에러가 발생하면 스크림트 실행을 중지
set -e

# MariaDB 데이터 디렉토리가 초기화 되었는지 확인합니다.
if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initializing MariaDB Data Directory..."
	mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
fi


cd /usr/local/bin

echo "Starting MariaDB server..."
./init-db.sh
