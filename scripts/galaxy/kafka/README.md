# kafka docker

* kafka haven't offcial docker image, use a popular one
    docker pull wurstmeister/kafka

* kafka manager
    docker pull kafkamanager/kafka-manager
    
* Tutorial
    http://wurstmeister.github.io/kafka-docker/
    https://hub.docker.com/r/kafkamanager/kafka-manager

* Run docker
    run example:
    a. ./run.sh -e KAFKA_ZOOKEEPER_CONNECT=calvin.cluster.1:2181 \
                -e KAFKA_ADVERTISED_HOST_NAME=calvin.cluster.1
    b. docker run -d -it --name=kafka-manager -e ZK_HOSTS=calvin.cluster.1 \
        --net=host --restart=always kafkamanager/kafka-manager
