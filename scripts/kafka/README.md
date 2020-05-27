# kafka docker

* kafka haven't offcial docker image, use a popular one
    docker pull wurstmeister/kafka
    
* Tutorial
    http://wurstmeister.github.io/kafka-docker/

* Run docker
    run example:
    a. ./run.sh -e KAFKA_ZOOKEEPER_CONNECT=localhost:2181 \
                -e KAFKA_ADVERTISED_HOST_NAME=localhost