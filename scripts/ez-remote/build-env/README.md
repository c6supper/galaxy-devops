# EZ-Remote building environment docker image builder

* pull the building environment docker image from registry
    1. docker pull veex.docker.mirror:5000/ez-remote/build-env:latest
    
* build preview docker
    1. ../../build-env/build.sh ez-remote build-env 
    
* build release docker
    1. change the version file
    2. ../../build-env/build.sh ez-remote build-env release
    
* Run docker
    1. docker run -d -v /(host directory):/home/ez-remote:rw -p 3022:22 ez-remote/build-env:latest
    2. ssh root@127.0.0.1 -p 3022
