#!/usr/bin/env bash

sudo systemctl stop apache2
sudo systemctl stop apache2.service
sudo systemctl stop mongodb
sudo systemctl stop postgresql

# Docker
sudo usermod -aG docker $USER
sudo systemctl restart docker

# memmory for elasticsearch
sudo sysctl -w vm.max_map_count=262144

# correct rights for pgadmin
sudo chown -R 5050:5050 ~/.laradock/data/pgadmin

export BUILD='' # '--build'

declare -a arr=( \
"blackfire" \
"apache2" \
"docker-registry" "docker-web-ui" \
"dejavu" "kibana" "manifoldcf" \
"memcached" \
"redis-webui" \
"mongo" \
"phpmyadmin" \
"pgadmin" "postgres" \
"beanstalkd-console" "rabbitmq" "sqs" \
"mailhog"
)

# above also includes
# "php-fpm" "workspace"
# "docker"
# "redis"
# "mysql"
# "postgres"
# "beanstalkd"

# above can optinally do
# "mailcatcher"

# above fails for
# "mongo-webui" # It looks like you are trying to access MongoDB over HTTP on the native driver port.
# "react"

for i in "${arr[@]}"
do
    export CONTAINER="$i"
    docker-compose up -d ${BUILD} ${CONTAINER}
done