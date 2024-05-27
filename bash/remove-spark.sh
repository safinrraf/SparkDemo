#!/bin/bash

PROGRAM=${0##*/} # the version
VERSION="$PROGRAM v1.0.0"
LOG_TIME_FORMAT="%F %T"

BASE_DIR=~/programm/sparkDemo
DOCKER_COMPOSE_YML=$BASE_DIR/docker-compose.yml

# debug mode
set -x

echo "$(date +"$LOG_TIME_FORMAT") Start $VERSION"
echo "$(date +"$LOG_TIME_FORMAT") BASE_DIR $BASE_DIR"

#docker login -u $DOCKER_USER -p $DOCKER_PASS

docker compose -f $DOCKER_COMPOSE_YML down --volumes --rmi all

docker system prune -af

echo "$(date +"$LOG_TIME_FORMAT") End $VERSION"