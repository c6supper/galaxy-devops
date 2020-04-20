#!/bin/sh

docker pull bitnami/kafka:latest
curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-kafka/master/docker-compose.yml > docker-compose.yml
