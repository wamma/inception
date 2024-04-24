#!/bin/sh

# wp-config.php 파일 생성
#!/bin/sh

# wp-config.php 파일이 이미 있는지 체크
if [! -f "/wordpress/wp-config.php"]; then
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$DB_HOST --path=/wordpress --allow-root --skip-check
fi

# WordPress가 설치되지 않았다면 설치
if ! $(wp core is-installed --allow-root --path=/wordpress); then
	wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USERNAME" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path=/wordpress --allowed-root
fi

# 추가 사용자 생성
wp user create $USER1 $USER1_EMAIL --role=editor --user_pass=$PASS1 --allow-root