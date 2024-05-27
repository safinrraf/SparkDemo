#!/bin/bash

PROGRAM=${0##*/} # the version
VERSION="$PROGRAM v1.0.0"
LOG_TIME_FORMAT="%F %T"

BASE_DIR=~/programm/sparkDemo
DOCKER_COMPOSE_YML=$BASE_DIR/docker-compose.yml

loggging() {
    local message=$1
    echo "$(date +"$LOG_TIME_FORMAT") $message"
}

source $BASE_DIR/bash/env.sh

# debug mode
set -x

loggging "Start $VERSION"
loggging "BASE_DIR $BASE_DIR"

docker login -u $DOCKER_USER --password-stdin < ./docker_password.pswd
docker compose -f $DOCKER_COMPOSE_YML down --volumes --rmi all
docker system prune -af
docker compose -f $DOCKER_COMPOSE_YML up -d

loggging "End $VERSION"