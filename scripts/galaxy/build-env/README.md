# galaxy building environment docker image builder

* pull the building environment docker image from registry
    1. docker pull calvin.docker.mirror:5000/galaxy/build-env:latest
    
* build preview docker
    1. ../../build-env/build.sh galaxy build-env 
    
* build release docker
    1. change the version file
    2. ../../build-env/build.sh galaxy build-env release
    
* Run docker
    1. docker run -d -v /(host directory):/home/galaxy:rw -p 3022:22 galaxy/build-env:latest
    2. ssh root@127.0.0.1 -p 3022
