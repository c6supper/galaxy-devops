# Using kubesphere as the DevOps

* detail refer to https://github.com/kubesphere/kubesphere

* start with multi-nodes cases
    1. curl -L https://kubesphere.io/download/stable/latest > installer.tar.gz \
       && tar -zxf installer.tar.gz && cd kubesphere-all-v2.1.1/scripts
    2. change ../conf/common.yaml
    3. change ../conf/host.ini
    3. sudo ./install.sh
