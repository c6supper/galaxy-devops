# nginx 1.19.0 with external modules docker

* Dockerfile for nginx, changed repositories to mirrors in China. 
       
* Build docker
    1.export nginx source code to directory "nginx"
    2.export nginx profiles to directory "etc/nginx"
    3.docker build --no-cache -t galaxy:nginx -f Dockerfile ./
