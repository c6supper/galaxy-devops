# canal-server docker

* pull the building environment docker image from registry
    1. $ docker pull zookeeper:3.6.1

       
* Run docker
    1. docker run --name galaxy-zookeeper --restart=always --net=host -d zookeeper:3.6.1
