# Nginx building environment docker image builder

* build preview docker
    1. ../../build-env/build.sh ezremote build-env 
* build release docker
    1. change the version file
    2. ../../build-env/build.sh ezremote build-env release
    
* Run docker
    1. docker run -d -v /(host directory):/home/ezremote:rw -p 3022:22 ezremote/build-env:latest
    2. ssh root@127.0.0.1 -p 3022
