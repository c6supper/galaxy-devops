# nginx 1.19.0 with external modules docker

* Dockerfile for nginx, changed repositories to mirrors in China. 
       
* Build docker
    1.export nginx source code to directory "nginx"
    2.export nginx profiles to directory "etc/nginx"
    3.docker build --no-cache -t c6supper/galaxy-nginx -f Dockerfile ./
    
* Build release docker
    1. change the version
    2. ../../build-env/build.sh c6supper galaxy-nginx release
