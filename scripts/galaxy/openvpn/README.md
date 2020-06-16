# OpenVPN Server Dockerfile

* devices could connect to galaxy with OpenVPN
       
* Build docker
    1.export openvpn configuration to "./etc"
    2.docker build --no-cache -t galaxy:openvpn -f Dockerfile ./
