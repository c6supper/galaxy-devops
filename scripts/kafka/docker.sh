#!/bin/sh

docker pull bitnami/kafka:latest
wget https://mirror.bit.edu.cn/apache/kafka/2.5.0/kafka_2.12-2.5.0.tgz
# curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-kafka/master/docker-compose.yml > docker-compose.yml
