FROM mysql:5.7

COPY ./beer.sql ./docker-entrypoint-initdb.d