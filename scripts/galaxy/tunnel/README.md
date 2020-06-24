# OpenVPN Server Dockerfile

* device could connect to galaxy with tunnel
       
* Build docker
    1.export openvpn configuration to "./etc"
    2.docker build --no-cache -t c6supper/galaxy-tunnel -f Dockerfile ./

* build release docker
    1. change the version
    2. ../../build-env/build.sh c6supper galaxy-tunnel release