#!/bin/bash
sudo docker run -d -v /data/docker:/data --name webdata busybox >/dev/null 2>&1
#network
sudo docker network create --subnet=172.18.0.0/16 --gateway=172.18.0.1 standalone_subnet >/dev/null 2>&1
#mysql
sudo docker run -d -v /data/docker/data/mysql:/var/lib/mysql -v /data/docker/conf/mysql:/etc/mysql/conf.d -p 8306:3306 -e MYSQL_ROOT_PASSWORD=3344520 --network standalone_subnet --ip 172.18.0.2 --name mysql mysql:5.7 >/dev/null 2>&1
#redis
sudo docker run -d -v /data/docker/data/redis:/data -p 6379:6379 --network standalone_subnet --ip 172.18.0.3 --name redis redis:latest redis-server --appendonly yes >/dev/null 2>&1
#mongo
sudo docker run -d -v /data/docker/data/mongo:/data/db -p 27017:27017 --network standalone_subnet --ip 172.18.0.4 -e MONGO_INITDB_ROOT_USERNAME="justin" -e MONGO_INITDB_ROOT_PASSWORD="3344520" --name mongo mongo:latest >/dev/null 2>&1
sudo docker run -d --network standalone_subnet --ip 172.18.0.5 -p 8081:8081 -e ME_CONFIG_OPTIONS_EDITORTHEME="ambiance" -e ME_CONFIG_BASICAUTH_USERNAME="justin" -e ME_CONFIG_BASICAUTH_PASSWORD="3344520" -e ME_CONFIG_MONGODB_SERVER="mongo" -e ME_CONFIG_MONGODB_ADMINUSERNAME="justin" -e ME_CONFIG_MONGODB_ADMINPASSWORD="3344520" --name mongo-express mongo-express:latest >/dev/null 2>&1
#memcached
#sudo docker run -d -p 11211:11211 --network standalone_subnet --ip 172.18.0.11 --name memcached memcached:latest > /dev/null 2>&1
#rabbitmq
#sudo docker run -d --hostname rabbitmq -p 15672:15672 -e RABBITMQ_DEFAULT_USER=justin -e RABBITMQ_DEFAULT_PASS=3344520 --network standalone_subnet --ip 172.18.0.12 --name rabbitmq  rabbitmq:latest > /dev/null 2>&1
#postgres
#sudo docker run -d -v /data/docker/data/postgres:/var/lib/postgresql -p 5432:5432 -e POSTGRES_PASSWORD=3344520 --network standalone_subnet --ip 172.18.0.13  --name postgres postgres:latest > /dev/null 2>&1

#php7.3
sudo docker run -d -v /data/docker/codes/php:/var/www/html -p 9002:9000 --network standalone_subnet --ip 172.18.0.7 --name php73 justintung/php:7.3-fpm >/dev/null 2>&1
#php7.4
sudo docker run -d -v /data/docker/codes/php:/var/www/html -p 9000:9000 --network standalone_subnet --ip 172.18.0.8 --name php74 justintung/php:7.4-fpm >/dev/null 2>&1
#php5.6
sudo docker run -d -v /data/docker/codes/php:/var/www/html -p 9001:9000 --network standalone_subnet --ip 172.18.0.9 --name php56 justintung/php:5.6-fpm >/dev/null 2>&1

#nginx
sudo docker run -d -v /data/docker/codes:/usr/share/nginx/html -v /data/docker/logs:/usr/share/nginx/logs -v /data/coding/config/vhosts:/etc/nginx/vhosts -v /data/docker/conf/nginx/nginx.conf:/etc/nginx/nginx.conf --link php74:php74 --link php73:php73 --link php56:php56 --link mysql:mysql --link mongo:mongo --link redis:redis -p 80:80 --network standalone_subnet --ip 172.18.0.10 --privileged=true --name nginx nginx:latest >/dev/null 2>&1
