FROM mysql:8.0.16

ENV MYSQL_DATABASE onevision
ENV MYSQL_ROOT_PASSWORD root

COPY ./scripts.sql/ /docker-entrypoint-initdb.d/
EXPOSE 3306
