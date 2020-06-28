# guild guacd 1.1.0 docker

* Dockerfile is from guacamole-server 1.1.0, changed repositories to mirrors. 
       
* Build docker
    1. docker build --no-cache -t c6supper/galaxy-guacd -f Dockerfile ./

* Build release docker
    1. change the version
    2. ../../build-env/build.sh c6supper galaxy-guacd release
