# Alpine 버전 설정
FROM alpine:3.18

# RUN 커맨드로 mysql관련 파일들 받기
RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    mariadb-server-utils \
    openrc \
    && (getent group mysql || addgroup mysql) \
    && (id mysql || adduser -D -G mysql mysql) \
    && mkdir /scripts

# 환경변수 설정
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}

# 초기 스크립트 복사(이 스크립트는 컨테이너 시작 시 MariaDB를 초기화합니다.)
COPY ./tools/*.sh /scripts/

# MariaDB의 설정 파일을 컨테이너에 추가합니다.
# conf.d 폴더 아래의 .conf 파일을 통해 설정을 추가할 수 있습니다.
COPY ./tools/*.cnf /etc/mysql/mariadb.conf.d/


# 데이터 지속을 위해 docker-compose.yml과 함께 MariaDB 데이터의 볼륨 구성입니다.
VOLUME [ "/var/lib/mysql" ]

# 포트 설정
EXPOSE 3306

# MariaDB 초기화 및 실행 스크립트 실행
COPY ./tools/entrypoint.sh /usr/local/bin/
COPY ./tools/init-db.sh /usr/local/bin/
RUN chmod -R 755 /etc/mysql/mariadb.conf.d/my.cnf
RUN chmod -R 755 /usr/local/bin/entrypoint.sh
RUN chmod -R 755 /usr/local/bin/init-db.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

# 이 상태 확인은 실패 시 컨테이너가 다시 시작되도록 하는데 도움이 됩니다.
# mysqladmin 유틸리티를 사용하여 로컬 호스트에 대해 MySQL 서버(MariaDB 포함)가 실행중인지 확인합니다.
# 성공 시 0 실패 시 (exit 1)
HEALTHCHECK --interval=10s --timeout=30s --start-period=5s --retries=3 \
 CMD mysqladmin ping -h localhost || exit 1

