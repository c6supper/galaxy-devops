# guild guacd 1.1.0 docker

* Dockerfile is from guacamole-server 1.1.0, we changed these deb repositories to mirros in China for that file. 
       
* Build docker
    1. docker build --no-cache -t galaxy:guacd -f Dockerfile ./
