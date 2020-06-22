# web client docker

* Dockerfile for web client, changed repositories to mirrors in China. 
       
* Build docker
    1.export client app to current directory
    2.export tomcat profiles to directory "etc/tomcat"
    3.export client profiles to directory "etc/guacamole"
    4.docker build --no-cache -t galaxy:ezremote-client -f Dockerfile ./
