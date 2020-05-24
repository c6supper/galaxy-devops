# canal-server docker

* pull the building environment docker image from registry
    1. $ docker pull zookeeper:3.6.1

       
* Run docker
    1. docker run -p 2181:2181 -p 2888:2888 -p 3888:3888 -p 8080:8080  --name ez-remote-zookeeper --restart always -d zookeeper:3.6.1
