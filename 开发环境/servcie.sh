#!/bin/bash
sudo docker run -d -v /coding/data:/data --name webdata busybox > /dev/null 2>&1
sudo docker network create --subnet=172.18.0.0/16 --gateway=172.18.0.1 standalone_subnet > /dev/null 2>&1
sudo docker run -d -v /coding/data/mysql:/var/lib/mysql -v /coding/config/mysql:/etc/mysql/conf.d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=3344520 --network standalone_subnet --ip 172.18.0.2 --name mysql mysql:5.7 > /dev/null 2>&1
sudo docker run -d -v /coding/data/redis:/data -p 6379:6379 --network standalone_subnet --ip 172.18.0.3 --name redis redis:latest redis-server --appendonly yes > /dev/null 2>&1
sudo docker run -d -v /coding/codes/php:/var/www/html  -v /coding/config/php/php56:/usr/local/etc/php -p 9000:9000 --network standalone_subnet --ip 172.18.0.9  --name php56 justintung/php:5.6-fpm > /dev/null 2>&1
sudo docker run -d -v /coding/codes/php:/var/www/html  -v /coding/config/php/php73:/usr/local/etc/php -p 9001:9000 --network standalone_subnet --ip 172.18.0.10  --name php73 justintung/php:7.3-fpm > /dev/null 2>&1
sudo docker run -d -v /coding/codes:/usr/share/nginx/html  -v /coding/config/nginx/vhosts:/etc/nginx/vhosts -v /coding/config/nginx/nginx.conf:/etc/nginx/nginx.conf --link php56:php56 --link php71:php71 --link php73:php73 --link mysql:mysql --network standalone_subnet --ip 172.18.0.110 -p 80:80 --privileged=true --name nginx nginx:latest
