#!/bin/sh

set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB Data Directory..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
fi

chmod -R 777 /var/lib/mysql

echo "Starting MariaDB server..."
exec /usr/local/bin/init-db.sh
